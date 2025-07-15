//
//  PetListViewModel.swift
//  Pet Matcher
//
//  Created by Kate Moreland on 7/15/25.
//

import Foundation

class PetListViewModel: ObservableObject {
    @Published var pets: [Pet] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func fetchPets(token: String, preferences: LifestylePreferences) {
        isLoading = true
        errorMessage = nil
        
        let type = preferences.activityLevel == "High" ? "dog" : "cat"
        
        let age: String
        switch preferences.availableTime {
        case "Lots": age = "baby"
        case "Moderate": age = "young"
        default: age = "adult"
        }
        
        let size: String
        switch preferences.homeType {
        case "Apartment": size = "small"
        default: size = "medium"
        }
        
        // boolean features
        let goodWithChildren = "true"
        let goodWithDogs = "true"
        let houseTrained = "true"
        
        guard !preferences.zipCode.trimmingCharacters(in: .whitespaces).isEmpty else {
            DispatchQueue.main.async {
                self.errorMessage = "Please enter a ZIP code in the quiz."
                self.isLoading = false
            }
            return
        }

        
        // URL with query items
        var components = URLComponents(string: "https://api.petfinder.com/v2/animals")
        components?.queryItems = [
            URLQueryItem(name: "type", value: type),
            URLQueryItem(name: "age", value: age),
            URLQueryItem(name: "size", value: size),
            URLQueryItem(name: "good_with_children", value: goodWithChildren),
            URLQueryItem(name: "good_with_dogs", value: goodWithDogs),
            URLQueryItem(name: "house_trained", value: houseTrained),
            URLQueryItem(name: "limit", value: "20"),
            URLQueryItem(name: "location", value: preferences.zipCode)
        ]
        
        guard let url = components?.url else {
            DispatchQueue.main.async {
                self.errorMessage = "Invalid URL"
                self.isLoading = false
            }
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            DispatchQueue.main.async {
                self?.isLoading = false
            }
            
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    self?.errorMessage = "Failed to fetch pets"
                }
                return
            }
            
            // Print for debugging
            if let json = String(data: data, encoding: .utf8) {
                print("API JSON:\n\(json)")
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decoded = try decoder.decode(PetResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.pets = decoded.animals
                }
            } catch {
                DispatchQueue.main.async {
                    self?.errorMessage = "Failed to decode response: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
}
