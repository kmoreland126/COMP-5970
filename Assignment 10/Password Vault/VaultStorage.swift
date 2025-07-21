//
//  VaultStorage.swift
//  Password Vault
//
//  Created by Kate Moreland on 7/20/25.
//

import Foundation
import CryptoKit

class VaultStorage {
    private let filename = "vault.dat"

    // Static key for demo only (in real app, derive securely)
    private let key = SymmetricKey(data: "YourSuperSecretKeyData1234567890".data(using: .utf8)!)

    private var vaultURL: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(filename)
    }

    func saveVault(entries: [PasswordEntry]) throws {
        let encoder = JSONEncoder()
        let data = try encoder.encode(entries)

        let sealedBox = try AES.GCM.seal(data, using: key)
        try sealedBox.combined!.write(to: vaultURL)
    }

    func loadVault() throws -> [PasswordEntry] {
        let data = try Data(contentsOf: vaultURL)
        let sealedBox = try AES.GCM.SealedBox(combined: data)
        let decrypted = try AES.GCM.open(sealedBox, using: key)

        return try JSONDecoder().decode([PasswordEntry].self, from: decrypted)
    }

    func vaultFileExists() -> Bool {
        FileManager.default.fileExists(atPath: vaultURL.path)
    }
}
