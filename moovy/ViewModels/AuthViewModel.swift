
import Foundation
import Combine
import FirebaseFirestore
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var userProfile: Profile?
    @Published var loading: Bool = false
    @Published var isAuthenticated: Bool = false
    @Published var errorMessage: String = ""
    @Published var genreName: String = ""
    var cancellables = Set<AnyCancellable>()
    let db = Firestore.firestore()
    var uid: String? = Auth.auth().currentUser?.uid
    
    func registerUser(user: User, onComplete: @escaping (_ authResult: AuthDataResult?, _ error: String?) -> Void) async {
        errorMessage = ""
        loading = true
        do {
            let authResult = try await Auth.auth().createUser(withEmail: user.email, password: user.password)
            print("User registered successfully: \(authResult.user.email ?? "")")
            loading = false
            onComplete(authResult, nil)
        } catch let error as NSError {
            errorMessage = error.localizedDescription
            print("Registration failed with error: \(error.localizedDescription)")
            loading = false
            onComplete(nil, error.localizedDescription)
        }
    }
    
    func loginUser(user: User, onComplete: @escaping (_ authResult: AuthDataResult?, _ error: String?) -> Void) async{
        errorMessage = ""
        loading = true
        
        do {
            let authResult = try await Auth.auth().signIn(withEmail: user.email, password: user.password)
            
            loading = false
            onComplete(authResult, nil)
            print("User logged in successfully: \(authResult.user.email ?? "")")
        } catch {
            print("Login failed with error: \(error.localizedDescription)")
            loading = false
            onComplete(nil, error.localizedDescription)
        }
    }
    
    func signout(onComplete: @escaping (_ error: String?) -> Void) async{
        errorMessage = ""
        loading = true
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            loading = false
            onComplete(nil)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
            loading = false
            onComplete("\(signOutError)")
        }
    }
    
    func resetPassword(email: String, onComplete: @escaping (_ error: String?) -> Void) async{
        errorMessage = ""
        loading = true
        
        let firebaseAuth = Auth.auth()
        do {
            try await firebaseAuth.sendPasswordReset(withEmail: email)
            loading = false
            onComplete(nil)
        } catch let resetError as NSError {
            print("Error sending reset email: %@", resetError)
            loading = false
            onComplete("\(resetError)")
        }
    }
    
    func checkAuthentication() async{
        
        self.isAuthenticated = Auth.auth().currentUser?.uid != nil ? true : false
    }
    
    func updateProfile(userProfile: Profile, onComplete: @escaping (_ error: String?) -> Void) async{
        errorMessage = ""
        loading = true
        let user = Auth.auth().currentUser
        
        var updateProfile = userProfile
        
        do {
            let uid = user!.uid
            let email = user!.email
            updateProfile.email = email
            try db.collection("users")
                .document(uid)
                .collection("profile")
                .document(uid)
                .setData(from: updateProfile)
            print("Document successfully written!")
            onComplete(nil)
            loading = false
        } catch let error {
            print("Error writing document: \(error)")
            onComplete("\(error)")
            loading = false
            errorMessage = error.localizedDescription
        }
    }
    
    func fetchProfile(onComplete: @escaping (_ error: Error?) -> Void) async {
        errorMessage = ""
        loading = true
        guard let uid = Auth.auth().currentUser?.uid else {
            print("UID is nil")
            onComplete(NSError(domain: "AppErrorDomain", code: -1, userInfo: [NSLocalizedDescriptionKey: "User ID is undefined"]))
            return
        }
        
        do {
            let documentSnapshot = try await db.collection("users")
                .document(uid)
                .collection("profile")
                .document(uid)
                .getDocument()
            let userProfile = try documentSnapshot.data(as: Profile.self)
            self.userProfile = userProfile
            print("Profile successfully fetched!")
            onComplete(nil)
            loading = false
        } catch {
            print("Error fetching profile: \(error)")
            onComplete(error)
            loading = false
            errorMessage = error.localizedDescription
        }
    }
    
    
}
