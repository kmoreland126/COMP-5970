//
//  AuthViewModel.swift
//  Pet Matcher
//
//  Created by Kate Moreland on 7/15/25.
//

import Foundation
import Combine

struct TokenResponse: Codable {
    let access_token: String
    let token_type: String
    let expires_in: Int
}

class AuthViewModel: ObservableObject {
    @Published var accessToken: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private var cancellable: AnyCancellable?

    var isAuthenticated: Bool {
        !accessToken.isEmpty
    }

    func fetchToken() {
        guard let url = URL(string: "https://api.petfinder.com/v2/oauth2/token") else {
            errorMessage = "Invalid URL"
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let clientID = "XqniJKW9OGz1usR74oe9IkFyxtlBgG0PpeAeMY8TyhzRI3yCk7"
        let clientSecret = "D5D7oRpFuHo22oAr0JCjkTrYdcOKF29FzARx2iib"
        let bodyParams = "grant_type=client_credentials&client_id=\(clientID)&client_secret=\(clientSecret)"
        
        request.httpBody = bodyParams.data(using: .utf8)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        isLoading = true
        errorMessage = nil

        cancellable = URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: TokenResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = "Token error: \(error.localizedDescription)"
                }
            }, receiveValue: { [weak self] token in
                self?.accessToken = token.access_token
                print("✅ Access token received: \(token.access_token)")
            })
    }
}
