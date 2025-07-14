//
//  FavoritesView.swift
//  Favorites
//
//  Created by Kate Moreland on 7/9/25.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var viewModel: FavoritesViewModel

    var body: some View {
        // Favorites
        let favoriteCities = viewModel.cities.filter { $0.isFavorite }
        let favoriteHobbies = viewModel.hobbies.filter { $0.isFavorite }
        let favoriteBooks = viewModel.books.filter { $0.isFavorite }

        NavigationView {
            List {
                // FavoriteCities
                if !favoriteCities.isEmpty {
                    Section(header: Text("Favorite Cities")) {
                        ForEach(favoriteCities) { city in
                            HStack {
                                Image(city.cityImage)
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))

                                Text(city.cityName)
                                Spacer()
                                Button(action: {
                                    viewModel.toggleCityFavorite(city)
                                }) {
                                    Image(systemName: city.isFavorite ? "heart.fill" : "heart")
                                        .foregroundColor(city.isFavorite ? .red : .gray)
                                }
                                .buttonStyle(BorderlessButtonStyle())
                            }
                            .listRowBackground(Color.gray.opacity(0.5))
                        }
                    }
                }

                // FavoriteHobbies
                if !favoriteHobbies.isEmpty {
                    Section(header: Text("Favorite Hobbies")) {
                        ForEach(favoriteHobbies) { hobby in
                            HStack {
                                Text("\(hobby.hobbyIcon) \(hobby.hobbyName)")
                                Spacer()
                                Button(action: {
                                    viewModel.toggleHobbyFavorite(hobby)
                                }) {
                                    Image(systemName: hobby.isFavorite ? "heart.fill" : "heart")
                                        .foregroundColor(hobby.isFavorite ? .red : .gray)
                                }
                                .buttonStyle(BorderlessButtonStyle())
                            }
                            .listRowBackground(Color.orange.opacity(0.5))
                        }
                    }
                }

                // FavoriteBooks
                if !favoriteBooks.isEmpty {
                    Section(header: Text("Favorite Books")) {
                        ForEach(favoriteBooks) { book in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(book.bookTitle).bold()
                                    Text(book.bookAuthor)
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                }
                                Spacer()
                                Button(action: {
                                    viewModel.toggleBookFavorite(book)
                                }) {
                                    Image(systemName: book.isFavorite ? "heart.fill" : "heart")
                                        .foregroundColor(book.isFavorite ? .red : .gray)
                                }
                                .buttonStyle(BorderlessButtonStyle())
                            }
                            .listRowBackground(Color.purple.opacity(0.5))
                        }
                    }
                }

                // If no favorite
                if favoriteCities.isEmpty && favoriteHobbies.isEmpty && favoriteBooks.isEmpty {
                    Text("No favorites selected yet.")
                        .foregroundColor(.gray)
                        .italic()
                        .padding()
                        .listRowBackground(Color.clear)
                }
            }
            .listStyle(InsetGroupedListStyle())
            .scrollContentBackground(.hidden)
            .background(Color.red.opacity(0.4))
            .navigationTitle("Favorites")
        }
    }
}
