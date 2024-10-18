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
    @State private var wantsClearSkin: String = "" // Changed to text input for yes/no
    @State private var dailyWaterIntake: String = ""
    @State private var exerciseHours: String = "" // Updated for weekly exercise hours
    @State private var sleepHours: String = ""

    var onSubmit: (String, String, String, String, String, String) -> Void // Now 6 parameters

    var body: some View {
        VStack(spacing: 20) {
            Text("Health Goals")
                .font(.custom("AvenirNext-Bold", size: 36))
                .padding()

            // Current Weight Input
            TextField("Current Weight (kg)", text: $currentWeight)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .keyboardType(.decimalPad)
                .font(.custom("AvenirNext-Regular", size: 18))

            // Goal Weight Input
            TextField("Goal Weight (kg)", text: $goalWeight)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .keyboardType(.decimalPad)
                .font(.custom("AvenirNext-Regular", size: 18))

            // Weekly Exercise Hours Input
            TextField("How many hours of exercise every week?", text: $exerciseHours)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .keyboardType(.decimalPad)
                .font(.custom("AvenirNext-Regular", size: 18))

            // Daily Water Intake Input
            TextField("Daily Water Intake (liters)", text: $dailyWaterIntake)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .keyboardType(.decimalPad)
                .font(.custom("AvenirNext-Regular", size: 18))

            // Sleep Hours Input
            TextField("Hours of Sleep per Night", text: $sleepHours)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .keyboardType(.decimalPad)
                .font(.custom("AvenirNext-Regular", size: 18))

            // Skin Improvement Input (Yes/No)
            TextField("Do you want to improve your skin? (yes/no)", text: $wantsClearSkin)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .font(.custom("AvenirNext-Regular", size: 18))

            // Submit Button
            Button(action: {
                // Call the onSubmit closure with six parameters
                onSubmit(currentWeight, goalWeight, wantsClearSkin, dailyWaterIntake, exerciseHours, sleepHours)
            }) {
                Text("Submit")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .font(.custom("AvenirNext-Bold", size: 20))
            }
            .padding(.top, 20)
        }
        .padding()
    }
}
