//
//  ContentView.swift
//  Assignment 7
//
//  Created by Kate Moreland on 7/3/25.
//

import SwiftUI

struct EmojiCounter: Identifiable {
    let id = UUID()
    let emoji: String
    var count: Int
}

struct ContentView: View {
    @State private var counters: [EmojiCounter] = [
        EmojiCounter(emoji: "🐱", count: 0),
        EmojiCounter(emoji: "🐶", count: 0),
        EmojiCounter(emoji: "🐟", count: 0),
        EmojiCounter(emoji: "🦖", count: 0),
        EmojiCounter(emoji: "🐷", count: 0)
    ]

    var body: some View {
        NavigationView {
            ZStack {
                // Yellow Background
                Color.yellow.opacity(0.5)
                    .ignoresSafeArea()

                // List on top of background
                List {
                    
                    ForEach($counters) { $counter in
                        HStack {
                            Text("\(counter.emoji) Counter: \(counter.count)")
                                .foregroundColor(.blue)
                            Spacer()
                            HStack(spacing: 10) {
                                Button(action: {
                                    counter.count += 1
                                }) {
                                    Text("+")
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.black)
                                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.blue, lineWidth: 2))
                                }
                                .buttonStyle(.plain)
                                
                                Button(action: {
                                    counter.count -= 1
                                }) {
                                    Text("−")
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.black)
                                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.blue, lineWidth: 2))
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.vertical, 20)
                        .listRowBackground(Color.green.opacity(0.2))
                    }
                }
                .scrollContentBackground(.hidden)
                .background(Color.clear)
            }
            .navigationTitle("Let's Count Emojis!")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
