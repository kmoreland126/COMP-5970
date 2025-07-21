//
//  AddEditEntryView.swift
//  Password Vault
//
//  Created by Kate Moreland on 7/20/25.
//

import SwiftUI

struct AddEditEntryView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var vaultVM: VaultViewModel

    @State private var title: String = ""
    @State private var username: String = ""
    @State private var password: String = ""

    var entryToEdit: PasswordEntry?

    init(entryToEdit: PasswordEntry? = nil) {
        self.entryToEdit = entryToEdit
        _title = State(initialValue: entryToEdit?.title ?? "")
        _username = State(initialValue: entryToEdit?.username ?? "")
        _password = State(initialValue: entryToEdit?.password ?? "")
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Details")) {
                    TextField("Title", text: $title)
                    TextField("Username", text: $username)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    SecureField("Password", text: $password)
                }
            }
            .navigationTitle(entryToEdit == nil ? "Add Entry" : "Edit Entry")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveEntry()
                    }
                    .disabled(title.isEmpty || username.isEmpty || password.isEmpty)
                }

                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }

    private func saveEntry() {
        let entry = PasswordEntry(
            id: entryToEdit?.id ?? UUID(),
            title: title,
            username: username,
            password: password
        )

        if entryToEdit == nil {
            vaultVM.addEntry(entry)
        } else {
            vaultVM.updateEntry(entry)
        }

        presentationMode.wrappedValue.dismiss()
    }
}
