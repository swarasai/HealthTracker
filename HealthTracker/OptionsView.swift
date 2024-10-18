//
//  OptionsView.swift
//  HealthTracker
//
//  Created by Swarasai Mulagari on 10/9/24.
//

import SwiftUI

struct OptionsView: View {
    let currentWeight: String
    let goalWeight: String
    let wantsClearSkin: String // This is now a string, not a boolean
    let dailyWaterIntake: String
    let exerciseHours: String
    let sleepHours: String
    let onIngredientCheck: () -> Void
    let onMealPlan: () -> Void
    let onDietWaterPlan: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            // Display current user data
            Text("Your Health Goals")
                .font(.custom("AvenirNext-Bold", size: 24))
                .padding()

            Text("Current Weight: \(currentWeight) kg")
                .font(.custom("AvenirNext-Regular", size: 18))

            Text("Goal Weight: \(goalWeight) kg")
                .font(.custom("AvenirNext-Regular", size: 18))

            Text("Daily Water Intake: \(dailyWaterIntake) liters")
                .font(.custom("AvenirNext-Regular", size: 18))

            Text("Exercise Hours per Week: \(exerciseHours) hours")
                .font(.custom("AvenirNext-Regular", size: 18))

            Text("Hours of Sleep: \(sleepHours) per night")
                .font(.custom("AvenirNext-Regular", size: 18))

            Text("Wants to Improve Skin: \(wantsClearSkin.capitalized)")
                .font(.custom("AvenirNext-Regular", size: 18))

            // Ingredient Check Button
            Button(action: onIngredientCheck) {
                Text("Ingredient Check")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }

            // Meal Plan Button
            Button(action: onMealPlan) {
                Text("Meal Plan")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
            }

            // Diet/Water Plan Button
            Button(action: onDietWaterPlan) {
                Text("Diet/Water Plan")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.orange)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}
