//
//  SignUp.swift
//  moovy
//
//  Created by Oladimeji Oladiti on 08/05/2024.
//

import SwiftUI

struct SignUp : View {
    @StateObject private var viewModel = AuthViewModel()
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var rememberPassword = false
    @State private var passwordVisibility: Bool = false
    @State private var errorMessage: String = ""
    @FocusState var isFocused
    
    var body: some View {
        ZStack {
            ColorManager.backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 40) {
                Image("AppLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 180, height: 180)
                
                Text("Getting Started")
                    .font(Font.system(size: 35, weight: .bold))
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
                    
                    HStack {
                        if passwordVisibility {
                            TextField("", text: $password, prompt: Text("Password").foregroundColor(.gray))
                                .autocapitalization(.none)
                        } else {
                            SecureField("", text: $password, prompt: Text("Password").foregroundColor(.gray))
                                .autocapitalization(.none)
                        }
                        Button(action: {
                            self.passwordVisibility.toggle()
                        }) {
                            Image(systemName: passwordVisibility ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(Color.gray.opacity(0.7))
                        }
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray.opacity(0.9), lineWidth: 1))
                    .padding(10)
                    .foregroundColor(Color.white.opacity(0.7))
                    
                    SecureField("", text: $confirmPassword, prompt: Text("Confirm password").foregroundColor(.gray))
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
                    
                    Button(action: signUp) {
                        Text("Register")
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
                }
                .padding()
            }
        }
    }
    
    private func signUp() {
        // Basic email validation using regex
        if !username.isValidEmail() {
            errorMessage = "Invalid email address."
            return
        }
        
        // Validate password criteria with regex
        if !password.isValidPassword() {
            errorMessage = "Must contain uppercase, lowercase & number."
            return
        }
        
        // Confirm passwords match
        if password != confirmPassword {
            errorMessage = "Passwords don't match."
            return
        }
        
        errorMessage = "" // Clear error message on successful validation
        
        let user = User(email: username, password: password)
        
        Task {
            await viewModel.registerUser(user: user){ result, error in
                
                
                
            }
        }
    }
}

extension String {
    func isValidEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPred.evaluate(with: self)
    }
    
    func isValidPassword() -> Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$\\^\\-,_+=!%*?&])[A-Za-z\\d@$\\^\\-,_+=!%*?&]{8,}$"
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPred.evaluate(with: self)
    }
}

#Preview {
    SignUp()
}
