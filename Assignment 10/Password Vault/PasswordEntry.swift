//
//  PasswordEntry.swift
//  Password Vault
//
//  Created by Kate Moreland on 7/20/25.
//

import Foundation

struct PasswordEntry: Identifiable, Codable, Equatable {
    let id: UUID
    var title: String
    var username: String
    var password: String
}
