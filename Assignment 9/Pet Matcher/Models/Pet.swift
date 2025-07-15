//
//  Pet.swift
//  Pet Matcher
//
//  Created by Kate Moreland on 7/15/25.
//

import Foundation

struct Pet: Identifiable, Codable {
    let id: Int
    let name: String
    let age: String?           // ex. "Young", "Adult", "Senior"
    let gender: String?        // ex. "Male", "Female"
    let size: String?          // ex. "Small", "Medium", "Large"
    let coat: String?          // ex. "Short", "Medium", "Long"
    let description: String?
    let url: String?           // Petfinder URL to the pet's profile
    let photos: [PetPhoto]?
    let breeds: PetBreeds
    
    struct PetPhoto: Codable {
        let small: String?
        let medium: String?
        let large: String?
        let full: String?
    }
    
    struct PetBreeds: Codable {
        let primary: String?
        let secondary: String?
        let mixed: Bool?
        let unknown: Bool?
    }
    
}

struct PetResponse: Codable {
    let animals: [Pet]
}
