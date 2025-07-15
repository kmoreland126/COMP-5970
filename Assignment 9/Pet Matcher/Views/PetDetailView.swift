//
//  PetDetailView.swift
//  Pet Matcher
//
//  Created by Kate Moreland on 7/15/25.
//

import SwiftUI

struct PetDetailView: View {
    let pet: Pet
    @State private var isExpanded = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let photoURL = pet.photos?.first?.large,
                   let url = URL(string: photoURL) {
                    AsyncImage(url: url) { image in
                        image.resizable().scaledToFit()
                    } placeholder: {
                        Rectangle().fill(Color.gray.opacity(0.3))
                    }
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }

                Text(pet.name)
                    .font(.largeTitle)
                    .bold()

                Text(pet.breeds.primary ?? "Unknown Breed")
                    .font(.headline)
                    .foregroundColor(.secondary)

                if let description = pet.description {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(isExpanded ? description : String(description.prefix(200)))
                            .font(.body)

                        // Show Expand/Collapse button only if text is long
                        if description.count > 200 {
                            Button(isExpanded ? "Show Less" : "Show More") {
                                withAnimation {
                                    isExpanded.toggle()
                                }
                            }
                            .font(.caption)
                            .foregroundColor(.blue)
                        }
                    }
                }

                if let gender = pet.gender {
                    Text("Gender: \(gender)")
                }

                if let age = pet.age {
                    Text("Age: \(age)")
                }

                if let size = pet.size {
                    Text("Size: \(size)")
                }

                if let coat = pet.coat {
                    Text("Coat: \(coat)")
                }

                if let url = pet.url, let link = URL(string: url) {
                    Link("View on Petfinder", destination: link)
                        .padding(.top, 8)
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Pet Details")
    }
}
