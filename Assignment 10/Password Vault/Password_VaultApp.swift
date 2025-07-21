//
//  Password_VaultApp.swift
//  Password Vault
//
//  Created by Kate Moreland on 7/20/25.
//

import SwiftUI
import FirebaseCore

@main
struct PasswordVaultApp: App {
    @StateObject var authVM = AuthViewModel()
    @StateObject var vaultVM = VaultViewModel()

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authVM)
                .environmentObject(vaultVM)
        }
    }
}
