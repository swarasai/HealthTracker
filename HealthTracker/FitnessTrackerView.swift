//
//  FitnessTrackerView.swift
//  HealthTracker
//
//  Created by Swarasai Mulagari on 10/18/24.
//

import SwiftUI

struct FitnessTrackerView: View {
    @State private var showExerciseAnalyzer = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("4-Week Workout Plan")
                        .font(.custom("AvenirNext-Bold", size: 24))
                        .padding()

                    ForEach(1...4, id: \.self) { week in
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Week \(week)")
                                .font(.custom("AvenirNext-DemiBold", size: 20))
                            
                            ForEach(["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"], id: \.self) { day in
                                Text("\(day): \(workoutForDay(week: week, day: day))")
                                    .font(.custom("AvenirNext-Regular", size: 16))
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                    }

                    NavigationLink(destination: ExerciseAnalyzerView(), isActive: $showExerciseAnalyzer) {
                        Button(action: { showExerciseAnalyzer = true }) {
                            Text("Exercise Analyzer")
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Fitness Tracker")
        }
    }

    func workoutForDay(week: Int, day: String) -> String {
        // This is a placeholder. You should replace this with your actual workout plan.
        switch day {
        case "Monday":
            return "Full Body Strength"
        case "Tuesday":
            return "Cardio"
        case "Wednesday":
            return "Rest Day"
        case "Thursday":
            return "Lower Body Focus"
        case "Friday":
            return "Upper Body and Core"
        case "Saturday":
            return "Cardio"
        case "Sunday":
            return "Rest Day"
        default:
            return "No workout"
        }
    }
}
