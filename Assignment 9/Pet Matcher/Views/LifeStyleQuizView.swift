//
//  LifeStyleQuizView.swift
//  Pet Matcher
//
//  Created by Kate Moreland on 7/15/25.
//

import SwiftUI

struct LifestyleQuizView: View {
    @Binding var preferences: LifestylePreferences
    var onComplete: () -> Void

    var body: some View {
        Form {
            Section(header: Text("Activity Level")) {
                Picker("Activity Level", selection: $preferences.activityLevel) {
                    Text("Low").tag("Low")
                    Text("Moderate").tag("Moderate")
                    Text("High").tag("High")
                }
                .pickerStyle(SegmentedPickerStyle())
            }

            Section(header: Text("Available Time for Pet")) {
                Picker("Available Time", selection: $preferences.availableTime) {
                    Text("Little").tag("Little")
                    Text("Moderate").tag("Moderate")
                    Text("Lots").tag("Lots")
                }
                .pickerStyle(SegmentedPickerStyle())
            }

            Section(header: Text("Home Type")) {
                Picker("Home Type", selection: $preferences.homeType) {
                    Text("Apartment").tag("Apartment")
                    Text("House").tag("House")
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("Your Zip Code")) {
                TextField("Enter ZIP Code", text: $preferences.zipCode)
                    .keyboardType(.numberPad)
            }
            
            Section(header: Text("Additional Preferences")) {
                Toggle("Good with Children", isOn: $preferences.likesKids)
                Toggle("Good with other Dogs", isOn: $preferences.hasOtherDogs)
                Toggle("Must Be House Trained", isOn: $preferences.needsTrainedPets)
            }

            Button("Find My Perfect Pet") {
                onComplete()
            }
            .buttonStyle(.borderedProminent)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.top)
        }
        .navigationTitle("Lifestyle Quiz")
    }
}
