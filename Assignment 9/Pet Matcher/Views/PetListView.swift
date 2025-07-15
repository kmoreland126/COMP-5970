//
//  PetListView.swift
//  Pet Matcher
//
//  Created by Kate Moreland on 7/15/25.
//

import SwiftUI

struct PetListView: View {
    @ObservedObject var viewModel = PetListViewModel()
    let token: String
    let preferences: LifestylePreferences
    let onBackToQuiz: () -> Void

    var body: some View {
        VStack {
            if viewModel.isLoading {
                VStack {
                    Image("Animals")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                    Text("Finding your perfect match...")
                        .padding(.top)
                }
                .padding()
            } else if let error = viewModel.errorMessage {
                VStack(spacing: 12) {
                    Text("⚠️ Error")
                        .font(.title)
                    Text(error)
                        .multilineTextAlignment(.center)
                        .padding()
                    Button("Try Again") {
                        viewModel.fetchPets(token: token, preferences: preferences)
                    }
                    .buttonStyle(.borderedProminent)
                    Button("🔙 Back to Quiz") {
                        onBackToQuiz()
                    }
                    .buttonStyle(.bordered)
                }
                .padding()
            } else if viewModel.pets.isEmpty {
                VStack {
                    Text("No pets matched your criteria.😿")
                        .font(.headline)
                        .padding()
                    Button("Try Again") {
                        viewModel.fetchPets(token: token, preferences: preferences)
                    }
                    .buttonStyle(.bordered)
                    Button("🔙 Back to Quiz") {
                        onBackToQuiz()
                    }
                    .buttonStyle(.bordered)
                }
            } else {
                VStack {
                    Button("🔙 Back to Quiz") {
                        onBackToQuiz()
                    }
                    .padding()
                    .buttonStyle(.bordered)

                    List(viewModel.pets) { pet in
                        NavigationLink(destination: PetDetailView(pet: pet)) {
                            HStack(spacing: 16) {
                                if let photoURL = pet.photos?.first?.medium,
                                   let url = URL(string: photoURL) {
                                    AsyncImage(url: url) { image in
                                        image.resizable().scaledToFill()
                                    } placeholder: {
                                        Rectangle().foregroundColor(.gray.opacity(0.3))
                                    }
                                    .frame(width: 60, height: 60)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                } else {
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.2))
                                        .frame(width: 60, height: 60)
                                        .overlay(Text("🐾"))
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                }

                                VStack(alignment: .leading) {
                                    Text(pet.name).font(.headline)
                                    Text(pet.breeds.primary ?? "Unknown Breed")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    .listStyle(.plain)
                }
                .navigationTitle("Your Matches")
            }
        }
        .onAppear {
            if viewModel.pets.isEmpty {
                viewModel.fetchPets(token: token, preferences: preferences)
            }
        }
    }
}
