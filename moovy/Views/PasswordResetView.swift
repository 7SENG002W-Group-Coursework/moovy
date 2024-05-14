

import SwiftUI

struct PasswordResetView : View {
    @EnvironmentObject private var viewModel: AuthViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var username: String = ""
    @State private var errorMessage: String = ""
    @FocusState var isFocused
    @State private var showAlert = false
    @State private var showAlertB = false
    @State private var alertMessage = ""
    @State private var alertMessageB = ""
    
    var body: some View {
        ZStack {
            ColorManager.backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 40) {
                Image("AppLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 180, height: 180)
                
                Text("Reset Password")
                    .font(Font.system(size: 25, weight: .bold))
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .focused($isFocused)
                
                VStack(spacing: 10){
                    TextField("", text: $username, prompt: Text("Email").foregroundColor(.gray))
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.9), lineWidth: 1))
                        .padding(10)
                        .foregroundColor(Color.white.opacity(0.7))
                        .focused($isFocused)
                    
                    if !errorMessage.isEmpty {
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text(errorMessage)
                                .multilineTextAlignment(.leading)
                                .font(.system(size: 15, weight: .regular))
                                .foregroundColor(.red)
                                .padding()
                        }
                    }
                    
                    if !viewModel.errorMessage.isEmpty && !isFocused {
                        
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
                    
                    Button(action: {
                        alertMessage = "Are you sure you want to reset your password?"
                        showAlert = true
                    }) {
                        Text("Reset")
                            .font(Font.system(size: 20, weight: .bold))
                            .foregroundColor(Color.black)
                            .padding(10)
                            .frame(width: UIScreen.main.bounds.width - 53)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(Color.white)
                            )
                    }.padding(20)
                        .disabled(viewModel.loading)
                    
                    Text("Log In")
                        .underline()
                        .font(Font.system(size: 13, weight: .bold))
                        .foregroundColor(.gray)
                        .padding(20)
                }.padding()
                    .alert(alertMessage, isPresented: $showAlert) {
                        Button("Cancel", role: .cancel) {}
                        Button("Yes", role: .destructive) {
                            resetPassword()
                        }
                    }
                    .alert(alertMessageB, isPresented: $showAlertB) {
                        Button("Ok", role: .cancel) {
                            viewModel.loading = false
                            presentationMode.wrappedValue.dismiss()
                            
                        }
                    }
            }
        }
    }
    
    private func resetPassword() {
        if !username.isEmailValid() {
            errorMessage = "Invalid email address."
            return
        }
        errorMessage = ""
        
        Task {
            await viewModel.resetPassword(email: username){ error in
                
                if error == nil {
                    alertMessageB = "Password reset link has been sent to your email"
                    showAlertB = true
                }else{
                    errorMessage = "Failed to send password reset email."
                    
                }
                
            }
        }
    }
}

extension String {
    func isEmailValid() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPred.evaluate(with: self)
    }
}

#Preview {
    PasswordResetView()
        .environmentObject(AuthViewModel())
}
