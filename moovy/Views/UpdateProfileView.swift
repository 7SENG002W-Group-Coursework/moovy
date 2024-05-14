import SwiftUI

struct UpdateProfileView : View {
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var errorMessage: String = ""
    @FocusState var isFocused
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        ZStack {
            ColorManager.backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 40) {
                Image("AppLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 180, height: 180)
                
                Text("Update Your Profile")
                    .font(Font.system(size: 25, weight: .bold))
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .focused($isFocused)
                
                VStack(spacing: 20) {
                    TextField("", text: $firstName, prompt: Text("First Name").foregroundColor(.gray))
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.gray.opacity(0.9), lineWidth: 1))
                        .padding(10)
                        .foregroundColor(Color.white.opacity(0.7))
                        .focused($isFocused)
                    
                    TextField("", text: $lastName, prompt: Text("Last Name").foregroundColor(.gray))
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.gray.opacity(0.9), lineWidth: 1))
                        .padding(10)
                        .foregroundColor(Color.white.opacity(0.7))
                        .focused($isFocused)
                    
                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .multilineTextAlignment(.leading)
                            .font(.system(size: 15, weight: .regular))
                            .foregroundColor(.red)
                            .padding()
                    }
                    
                    if !errorMessage.isEmpty && !isFocused {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(viewModel.errorMessage)
                                .multilineTextAlignment(.leading)
                                .font(.system(size: 15, weight: .regular))
                                .foregroundColor(.red)
                                .padding()
                        }
                    }
                    
                    if viewModel.loading {
                        VStack(alignment: .leading, spacing: 5) {
                            Spinner()
                        }
                    }
                    
                    Button(action: updateProfile) {
                        Text("Update")
                            .font(Font.system(size: 20, weight: .bold))
                            .foregroundColor(Color.black)
                            .padding(10)
                            .frame(width: UIScreen.main.bounds.width - 53)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(Color.white)
                            )
                    }.alert(alertMessage, isPresented: $showAlert) {
                        Button("OK", role: .cancel) {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                    .padding(20)
                }
                .padding()
            }
        }
    }
    
    private func updateProfile() {
        guard !firstName.isEmpty, !lastName.isEmpty else {
            errorMessage = "Please fill in all fields."
            return
        }
        
        let updatedProfile = Profile(firstName: firstName, lastName: lastName, email: nil)
        
        Task {
            await viewModel.updateProfile(userProfile: updatedProfile) { error in
                if let error = error {
                    errorMessage = "Update failed: \(error)"
                } else {
                    showAlert = true
                    alertMessage = "Profile Update Successful"
                }
            }
        }
    }
}

#Preview {
    UpdateProfileView()
        .environmentObject(AuthViewModel())
}
