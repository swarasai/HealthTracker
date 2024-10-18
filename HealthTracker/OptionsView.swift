import SwiftUI

struct OptionsView: View {
    let currentWeight: String
    let goalWeight: String
    let wantsClearSkin: String
    let dailyWaterIntake: String
    let exerciseHours: String
    let sleepHours: String
    let onIngredientCheck: () -> Void
    let onMealPlan: () -> Void
    let onDietWaterPlan: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("Options")
                .font(.custom("AvenirNext-Bold", size: 36))
                .padding()

            Button(action: onIngredientCheck) {
                Text("Ingredient Check")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }

            Button(action: onMealPlan) {
                Text("Meal Plan")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(10)
            }

            Button(action: onDietWaterPlan) {
                Text("Diet/Water Plan")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.orange)
                    .cornerRadius(10)
            }

            // Display user's input
            Group {
                Text("Current Weight: \(currentWeight) kg")
                Text("Goal Weight: \(goalWeight) kg")
                Text("Wants Clear Skin: \(wantsClearSkin)")
                Text("Daily Water Intake: \(dailyWaterIntake) liters")
                Text("Weekly Exercise: \(exerciseHours) hours")
                Text("Nightly Sleep: \(sleepHours) hours")
            }
            .font(.custom("AvenirNext-Regular", size: 16))
            .foregroundColor(.black)
        }
        .padding()
    }
}
