//
//  VaultView.swift
//  Password Vault
//
//  Created by Kate Moreland on 7/20/25.
//

import SwiftUI

struct VaultView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @EnvironmentObject var vaultVM: VaultViewModel
    @State private var showingAddEntry = false
    @State private var editEntry: PasswordEntry?

    var body: some View {
        ZStack {
            Color.gray.opacity(0.2)
                .ignoresSafeArea()
        
            NavigationView {
                List {
                    ForEach(vaultVM.entries) { entry in
                        VStack(alignment: .leading) {
                            Text(entry.title).font(.headline)
                            Text(entry.username).font(.subheadline)
                            SecureTextView(password: entry.password)
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            editEntry = entry
                        }
                    }
                    .onDelete(perform: vaultVM.deleteEntry)
                }
                .navigationTitle("Password Vault 🔑")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Logout") {
                            authVM.signOut()
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: { showingAddEntry = true }) {
                            Image(systemName: "plus")
                        }
                    }
                }
                .sheet(isPresented: $showingAddEntry) {
                    AddEditEntryView()
                }
                .sheet(item: $editEntry) { entry in
                    AddEditEntryView(entryToEdit: entry)
                }
            }
            .background(Color.clear)
        }
    }
}

struct SecureTextView: View {
    let password: String
    @State private var isRevealed = false

    var body: some View {
        HStack {
            Group {
                if isRevealed {
                    Text(password)
                        .font(.body)
                        .foregroundColor(.primary)
                        .textSelection(.enabled) // allows copy/paste
                } else {
                    Text(String(repeating: "•", count: max(password.count, 6)))
                        .font(.body)
                        .foregroundColor(.secondary)
                }
            }
            Spacer()
            Button(action: { isRevealed.toggle() }) {
                Image(systemName: isRevealed ? "eye.slash.fill" : "eye.fill")
                    .foregroundColor(.blue)
            }
            .buttonStyle(PlainButtonStyle()) // to prevent button from changing style on tap
        }
        .padding(.vertical, 4)
    }
}
