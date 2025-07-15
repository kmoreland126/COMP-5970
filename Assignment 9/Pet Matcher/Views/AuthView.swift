//
//  AuthView.swift
//  Pet Matcher
//
//  Created by Kate Moreland on 7/15/25.
//

import SwiftUI

struct AuthView: View {
    @ObservedObject var viewModel: AuthViewModel

    var body: some View {
        VStack(spacing: 20) {
            if viewModel.isLoading {
                ProgressView("Logging in...")
            } else if let error = viewModel.errorMessage {
                Text("Error: \(error)")
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding()
            } else if viewModel.isAuthenticated {
                Text("Authenticated! 🎉")
                    .font(.headline)
            } else {
                Button("Get Access Token") {
                    viewModel.fetchToken()
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
        }
        .padding()
    }
}
