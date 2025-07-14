//
//  HomeView.swift
//  Favorites
//
//  Created by Kate Moreland on 7/9/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: FavoritesViewModel
    
    var body: some View {
        NavigationView {
                List {
                    // Cities
                    Section(header: Text("Cities")) {
                        ForEach(viewModel.cities) { city in
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
                                        .foregroundColor(.red)
                                }
                            }
                            .listRowBackground(Color.gray.opacity(0.5))
                        }
                    }
                    
                    // Hobbies
                    Section(header: Text("Hobbies")) {
                        ForEach(viewModel.hobbies) { hobby in
                            HStack {
                                Text("\(hobby.hobbyIcon) \(hobby.hobbyName)")
                                
                                Spacer()
                                Button(action: {
                                    viewModel.toggleHobbyFavorite(hobby)
                                }) {
                                    Image(systemName: hobby.isFavorite ? "heart.fill" : "heart")
                                        .foregroundColor(.red)
                                }
                            }
                            .listRowBackground(Color.orange.opacity(0.5))
                        }
                    }
                    
                    // Books
                    Section(header: Text("Books")) {
                        ForEach(viewModel.books) { book in
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
                                        .foregroundColor(.red)
                                }
                            }
                            .listRowBackground(Color.purple.opacity(0.5))
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .scrollContentBackground(.hidden)
                .background(Color.red.opacity(0.4))
                .navigationTitle("Home")
        }
    }
}
