//
//  HealthFormView.swift
//  HealthTracker
//
//  Created by Swarasai Mulagari on 10/9/24.
//

import SwiftUI

struct HealthFormView: View {
    @State private var currentWeight: String = ""
    @State private var goalWeight: String = ""
    @State private var wantsClearSkin: Bool = false

    var onSubmit: (String, String, Bool, String, String) -> Void // Expecting five parameters

    var body: some View {
        VStack {
            Text("Health Goals")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            TextField("Current Weight (kg)", text: $currentWeight)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .keyboardType(.decimalPad)
                .padding(.bottom, 10)

            TextField("Goal Weight (kg)", text: $goalWeight)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .keyboardType(.decimalPad)
                .padding(.bottom, 10)

            Toggle(isOn: $wantsClearSkin) {
                Text("Do you want to improve your skin?")
                    .font(.headline)
            }
            .padding()

            Button(action: {
                // Example placeholder values for extractedText and skinCondition
                let extractedText = "" // Set this based on your logic if needed
                let skinCondition = wantsClearSkin ? "Clear Skin" : "No Skin Concern"

                // Call the onSubmit closure with five parameters
                onSubmit(currentWeight, goalWeight, wantsClearSkin, extractedText, skinCondition)
            }) {
                Text("Submit")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.top, 20)
        }
        .padding()
    }
}
