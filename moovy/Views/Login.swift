
import SwiftUI

struct Login : View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var passwordVisibility: Bool = false
    @State private var errorMessage: String = ""
    @FocusState var isFocused
    @State var isRegisterSheetPresented = false
    @State var isPasswordResetSheetPresented = false

    var body: some View {
        ZStack {
            ColorManager.backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 40) {
                Image("AppLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 180, height: 180)
                
                Text("Welcome back")
                    .font(Font.system(size: 35, weight: .bold))
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .focused($isFocused)
                
                VStack(spacing: 10) {
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
                    
                    if !errorMessage.isEmpty {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(errorMessage)
                                .multilineTextAlignment(.leading)
                                .font(.system(size: 15, weight: .regular))
                                .foregroundColor(.red)
                                .padding()
                        }
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
                    
                    HStack{
                        Spacer()
                        Button(action: {
                            isPasswordResetSheetPresented = true
                        }) {
                            Text("Reset password? ")
                                .underline()
                                .italic()
                                .font(Font.system(size: 15, weight: .semibold))
                                .foregroundColor(.gray)
                        }.padding(.trailing, 10)
                        .sheet(isPresented: $isPasswordResetSheetPresented, onDismiss: {
                                
                                }) {
                                    PasswordResetView()
                                }
                            
                    }
                    
                    Button(action: logIn) {
                        Text("Log In")
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
                    
                    Button(action: {
                        isRegisterSheetPresented = true
                    }) {
                        HStack{
                            Text("Don't have an account? ")
                                .italic()
                                .font(Font.system(size: 15, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(0)
                            
                            Text("Sign Up")
                                .underline()
                                .font(Font.system(size: 15, weight: .bold))
                                .foregroundColor(.blue)
                                .padding(0)
                        }.padding(10)
                        
                    }.sheet(isPresented: $isRegisterSheetPresented, onDismiss: {
                        Task{
                            await viewModel.checkAuthentication()
                        }
                        }) {
                            SignUp()
                        }
                    

                }.padding()
            }
        }
    }
    
    private func logIn() {
        errorMessage = ""
        if !username.isValidEmail() {
            errorMessage = "Invalid email address."
            return
        }
        
        let user = User(email: username, password: password)
        
        Task {
            await viewModel.loginUser(user: user){ result, error in
                
                if error == nil {
                    viewModel.isAuthenticated = true
                }else{
                    
                    viewModel.isAuthenticated = false
                    errorMessage = "Failed login. Check details or register."
                    
                }
                
            }
        }
    }

}

#Preview {
    Login()
        .environmentObject(AuthViewModel())
}
