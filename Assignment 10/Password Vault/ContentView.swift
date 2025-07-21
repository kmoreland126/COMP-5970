//
//  ContentView.swift
//  Password Vault
//
//  Created by Kate Moreland on 7/20/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authVM: AuthViewModel

    var body: some View {
        Group {
            if authVM.isLoggedIn {
                VaultView()
            } else {
                LoginView()
            }
        }
        .animation(.easeInOut, value: authVM.isLoggedIn)
    }
}

