//
//  SplashScreenView.swift
//  HealthTracker
//
//  Created by Swarasai Mulagari on 10/9/24.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var navigateToForm = false
    @State private var scale: CGFloat = 0.5
    @State private var hideLogo = false
    @State private var navigateToOptions = false

    // State variables to hold user input
    @State private var currentWeight: String = ""
    @State private var goalWeight: String = ""
    @State private var wantsClearSkin: String = "" // This is now a string
    @State private var dailyWaterIntake: String = ""
    @State private var exerciseHours: String = ""
    @State private var sleepHours: String = ""

    var body: some View {
        ZStack {
            Color(red: 0.784, green: 0.894, blue: 0.937) // Lighter sky blue
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                if !hideLogo {
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .scaleEffect(scale)
                        .frame(width: 300, height: 300)
                        .onAppear {
                            withAnimation(.easeInOut(duration: 1.0)) {
                                scale = 1.0
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation {
                                    hideLogo = true
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    withAnimation {
                                        navigateToForm = true
                                    }
                                }
                            }
                        }
                }
                
                if navigateToForm {
                    // Call HealthFormView with the updated onSubmit closure (6 parameters)
                    HealthFormView(onSubmit: { weight, goal, wantsSkin, waterIntake, exerciseHours, sleepHours in
                        // Store the submitted values
                        currentWeight = weight
                        goalWeight = goal
                        wantsClearSkin = wantsSkin
                        dailyWaterIntake = waterIntake
                        self.exerciseHours = exerciseHours
                        self.sleepHours = sleepHours

                        // Navigate to options
                        navigateToOptions = true
                    })
                    .fullScreenCover(isPresented: $navigateToOptions) {
                        // Pass the correct parameters to OptionsView
                        OptionsView(
                            currentWeight: currentWeight,
                            goalWeight: goalWeight,
                            wantsClearSkin: wantsClearSkin,
                            dailyWaterIntake: dailyWaterIntake,
                            exerciseHours: exerciseHours,
                            sleepHours: sleepHours,
                            onIngredientCheck: {
                                // Handle Ingredient Check
                            },
                            onMealPlan: {
                                // Handle Meal Plan
                            },
                            onDietWaterPlan: {
                                // Handle Diet/Water Plan
                            }
                        )
                    }
                }
            }
        }
    }
}
