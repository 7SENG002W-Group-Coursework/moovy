//
//  AuthViewModel.swift
//  moovy
//
//  Created by Anthony Gibah on 5/12/24.
//

import Foundation
import Combine
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var loading: Bool = false
    @Published var isAuthenticated: Bool = false
    @Published var errorMessage: String = ""
    @Published var genreName: String = ""
    var cancellables = Set<AnyCancellable>()
    
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
            self.isAuthenticated = true
            onComplete(authResult, nil)
            print("User logged in successfully: \(authResult.user.email ?? "")")
        } catch {
            print("Login failed with error: \(error.localizedDescription)")
            loading = false
            self.isAuthenticated = false
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
            self.isAuthenticated = Auth.auth().currentUser?.uid != nil ? true : false
            onComplete(nil)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
            loading = false
            self.isAuthenticated = Auth.auth().currentUser?.uid != nil ? true : false
            onComplete("\(signOutError)")
        }
    }
    
    func checkAuthentication() async{
        
        self.isAuthenticated = Auth.auth().currentUser?.uid != nil ? true : false
    }
    
}
