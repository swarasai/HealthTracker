import SwiftUI

struct SplashScreenView: View {
    @State private var navigateToForm = false
    @State private var scale: CGFloat = 1.0
    @State private var opacity: Double = 0.0
    @State private var navigateToOptions = false

    // State variables to hold user input
    @State private var currentWeight: String = ""
    @State private var goalWeight: String = ""
    @State private var wantsClearSkin: String = ""
    @State private var dailyWaterIntake: String = ""
    @State private var exerciseHours: String = ""
    @State private var sleepHours: String = ""

    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            if !navigateToForm {
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .clipped()
                    .scaleEffect(scale)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 2.0)) {
                            opacity = 1.0
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation(.easeInOut(duration: 2.0)) {
                                scale = 1.2
                                opacity = 0.0
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                navigateToForm = true
                            }
                        }
                    }
            } else {
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
                            print("Meal Plan tapped")
                        },
                        onDietWaterPlan: {
                            // Handle Diet/Water Plan
                        }                    )
                }
            }
        }
    }
}
