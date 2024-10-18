import SwiftUI

struct HealthFormView: View {
    @State private var currentWeight = ""
    @State private var goalWeight = ""
    @State private var wantsClearSkin = ""
    @State private var dailyWaterIntake = ""
    @State private var exerciseHours = ""
    @State private var sleepHours = ""

    var onSubmit: (String, String, String, String, String, String) -> Void

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Health Profile")
                    .font(.custom("AvenirNext-Bold", size: 36))
                    .padding()

                Group {
                    textField(question: "What is your current weight in kg?", text: $currentWeight)
                    textField(question: "What is your goal weight in kg?", text: $goalWeight)
                    textField(question: "Do you want to improve your skin? (yes/no)", text: $wantsClearSkin)
                    textField(question: "How many liters of water do you drink daily?", text: $dailyWaterIntake)
                    textField(question: "How many hours do you exercise weekly?", text: $exerciseHours)
                    textField(question: "How many hours do you sleep per night?", text: $sleepHours)
                }

                Button(action: {
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

    private func textField(question: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading) {
            Text(question)
                .font(.custom("AvenirNext-Medium", size: 16))
                .foregroundColor(.blue)
            TextField("Enter your answer", text: text)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .font(.custom("AvenirNext-Regular", size: 18))
        }
    }
}
