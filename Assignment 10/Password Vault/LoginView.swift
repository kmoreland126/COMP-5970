//
//  LoginView.swift
//  Password Vault
//
//  Created by Kate Moreland on 7/20/25.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authVM: AuthViewModel
    
    @State private var email = ""
    @State private var password = ""
    @State private var isSignUpMode = false
    @State private var errorMessage: String?
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.2)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text(isSignUpMode ? "Sign Up" : "Login to PasswordVault")
                    .font(.title)
                    .bold()
                    .foregroundColor(.primary)
                
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                
                if let error = errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                }
                
                Button(isSignUpMode ? "Create Account" : "Login") {
                    errorMessage = nil
                    if isSignUpMode {
                        authVM.signUp(email: email, password: password) { error in
                            if let error = error {
                                errorMessage = error.localizedDescription
                            }
                        }
                    } else {
                        authVM.signIn(email: email, password: password) { error in
                            if let error = error {
                                errorMessage = error.localizedDescription
                            }
                        }
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(email.isEmpty || password.isEmpty)
                
                Button(isSignUpMode ? "Have an account? Login" : "Don't have an account? Sign Up") {
                    isSignUpMode.toggle()
                    errorMessage = nil
                }
                .font(.footnote)
            }
            .padding()
            .frame(maxWidth: 400)
        }
    }
}
