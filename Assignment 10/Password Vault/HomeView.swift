//
//  HomeView.swift
//  Password Vault
//
//  Created by Kate Moreland on 7/20/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome!").font(.largeTitle)

            Button("Logout") {
                do {
                    try authViewModel.signOut()
                } catch {
                    print("Error logging out: \(error.localizedDescription)")
                }
            }
        }
    }
}
