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
    let wantsClearSkin: Bool
    let onIngredientCheck: () -> Void
    let onMealPlan: () -> Void
    let onDietWaterPlan: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            // Button to go to Ingredient Check
            Button(action: onIngredientCheck) {
                Text("Ingredient Check")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }

            // Button to go to Meal Plan
            Button(action: onMealPlan) {
                Text("Meal Plan")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
            }

            // Button to go to Diet/Water Plan
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
