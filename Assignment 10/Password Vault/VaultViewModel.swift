//
//  VaultViewModel.swift
//  Password Vault
//
//  Created by Kate Moreland on 7/20/25.
//

import Foundation
import SwiftUI

class VaultViewModel: ObservableObject {
    @Published var entries: [PasswordEntry] = []

    private let storage = VaultStorage()

    init() {
        loadEntries()
    }

    func loadEntries() {
        do {
            if storage.vaultFileExists() {
                entries = try storage.loadVault()
            } else {
                entries = []
            }
        } catch {
            print("Failed to load vault: \(error)")
            entries = []
        }
    }

    func addEntry(_ entry: PasswordEntry) {
        entries.append(entry)
        saveEntries()
    }

    func updateEntry(_ entry: PasswordEntry) {
        if let index = entries.firstIndex(where: { $0.id == entry.id }) {
            entries[index] = entry
            saveEntries()
        }
    }

    func deleteEntry(at offsets: IndexSet) {
        entries.remove(atOffsets: offsets)
        saveEntries()
    }

    private func saveEntries() {
        do {
            try storage.saveVault(entries: entries)
        } catch {
            print("Failed to save vault: \(error)")
        }
    }
}
