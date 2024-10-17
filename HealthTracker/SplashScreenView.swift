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
    @State private var showPhotoCapture = false
    @State private var capturedImage: UIImage? = nil // To hold the captured image

    // State variables to hold user input
    @State private var currentWeight: String = ""
    @State private var goalWeight: String = ""
    @State private var wantsClearSkin: Bool = false

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
                        .offset(y: -30)
                        .padding()
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
                    HealthFormView(onSubmit: { weight, goal, wantsSkin, extractedText, skinCondition in
                        // Store the submitted values
                        currentWeight = weight
                        goalWeight = goal
                        wantsClearSkin = wantsSkin

                        // Navigate to options
                        navigateToOptions = true
                    })
                    .fullScreenCover(isPresented: $navigateToOptions) {
                        OptionsView(
                            currentWeight: currentWeight,
                            goalWeight: goalWeight,
                            wantsClearSkin: wantsClearSkin,
                            onIngredientCheck: {
                                showPhotoCapture = true // Show the photo capture view
                            },
                            onMealPlan: {
                                // Logic for meal plan navigation
                            },
                            onDietWaterPlan: {
                                // Logic for diet/water plan navigation
                            }
                        )
                        .fullScreenCover(isPresented: $showPhotoCapture) {
                            PhotoCaptureView(onImageCaptured: { image in
                                capturedImage = image // Handle the captured image
                                // Logic to process the image
                            })
                        }
                    }
                }
            }
        }
    }
}
