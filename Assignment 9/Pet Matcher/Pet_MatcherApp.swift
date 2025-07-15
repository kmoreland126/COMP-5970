//
//  Pet_MatcherApp.swift
//  Pet Matcher
//
//  Created by Kate Moreland on 7/15/25.
//

import SwiftUI

@main
struct Pet_MatcherApp: App {
    @StateObject private var authViewModel = AuthViewModel()
    @State private var lifestylePreferences = LifestylePreferences()
    @State private var isQuizCompleted = false

    var body: some Scene {
        WindowGroup {
            NavigationView {
                if !authViewModel.isAuthenticated {
                    AuthView(viewModel: authViewModel)
                        .onAppear {
                            authViewModel.fetchToken()
                        }
                } else if !isQuizCompleted {
                    LifestyleQuizView(preferences: $lifestylePreferences) {
                        isQuizCompleted = true
                    }
                } else {
                    PetListView(
                        token: authViewModel.accessToken,
                        preferences: lifestylePreferences,
                        onBackToQuiz: {
                            isQuizCompleted = false
                        }
                    )
                }
            }
        }
    }
}
