import SwiftUI

struct OptionsView: View {
    let name: String
    let currentWeight: String
    let goalWeight: String
    let height: String
    let age: String
    let gender: Int
    let activityLevel: Double
    let dailyWaterIntake: Double
    let exerciseHours: Double
    let sleepHours: Double
    let stressLevel: Int
    let energyLevel: Int
    let moodRating: Int
    let sittingHours: Double
    let motivationLevel: Int
    let fitnessGoals: Set<String>
    let exercisePreferences: Set<String>
    let supplements: Set<String>
    let medicalConditions: Set<String>
    let isVegan: Bool
    let isVegetarian: Bool
    let isLactoseIntolerant: Bool
    let wantsClearSkin: Bool
    let participatesInSports: Bool
    let hasRegularMealSchedule: Bool
    let studiesLate: Bool
    let usesScreenBeforeBed: Bool
    let hasExtracurricularActivities: Bool
    let experiencesTestAnxiety: Bool
    let hasDifficultiesConcentrating: Bool
    let onNutritionAnalyzer: () -> Void
    let onDietWaterPlan: () -> Void
    @State private var showFitnessTracker = false
    @State private var showMealScan = false
    @State private var showNutritionAnalyzer = false
    @State private var showExerciseAnalyzer = false

    init(name: String, currentWeight: String, goalWeight: String, height: String, age: String, gender: Int, activityLevel: Double, dailyWaterIntake: Double, exerciseHours: Double, sleepHours: Double, stressLevel: Int, energyLevel: Int, moodRating: Int, sittingHours: Double, motivationLevel: Int, fitnessGoals: Set<String>, exercisePreferences: Set<String>, supplements: Set<String>, medicalConditions: Set<String>, isVegan: Bool, isVegetarian: Bool, isLactoseIntolerant: Bool, wantsClearSkin: Bool, participatesInSports: Bool, hasRegularMealSchedule: Bool, studiesLate: Bool, usesScreenBeforeBed: Bool, hasExtracurricularActivities: Bool, experiencesTestAnxiety: Bool, hasDifficultiesConcentrating: Bool, onNutritionAnalyzer: @escaping () -> Void, onDietWaterPlan: @escaping () -> Void) {
        self.name = name
        self.currentWeight = currentWeight
        self.goalWeight = goalWeight
        self.height = height
        self.age = age
        self.gender = gender
        self.activityLevel = activityLevel
        self.dailyWaterIntake = dailyWaterIntake
        self.exerciseHours = exerciseHours
        self.sleepHours = sleepHours
        self.stressLevel = stressLevel
        self.energyLevel = energyLevel
        self.moodRating = moodRating
        self.sittingHours = sittingHours
        self.motivationLevel = motivationLevel
        self.fitnessGoals = fitnessGoals
        self.exercisePreferences = exercisePreferences
        self.supplements = supplements
        self.medicalConditions = medicalConditions
        self.isVegan = isVegan
        self.isVegetarian = isVegetarian
        self.isLactoseIntolerant = isLactoseIntolerant
        self.wantsClearSkin = wantsClearSkin
        self.participatesInSports = participatesInSports
        self.hasRegularMealSchedule = hasRegularMealSchedule
        self.studiesLate = studiesLate
        self.usesScreenBeforeBed = usesScreenBeforeBed
        self.hasExtracurricularActivities = hasExtracurricularActivities
        self.experiencesTestAnxiety = experiencesTestAnxiety
        self.hasDifficultiesConcentrating = hasDifficultiesConcentrating
        self.onNutritionAnalyzer = onNutritionAnalyzer
        self.onDietWaterPlan = onDietWaterPlan
        self._showFitnessTracker = State(initialValue: false)
        self._showMealScan = State(initialValue: false)
        self._showNutritionAnalyzer = State(initialValue: false)
        self._showExerciseAnalyzer = State(initialValue: false)
    }
    
    var body: some View {
        VStack {
            // Welcome message
            Text("Welcome, \(name)!")
                .onAppear {
                    print("Name in OptionsView: '\(name)'")
                    print("Name is empty: \(name.isEmpty)")
                }
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 40)

            // Main content area
            Spacer()

            // Tab bar at the bottom
            HStack {
                TabButton(title: "Nutrition", imageName: "fork.knife", action: {
                    showNutritionAnalyzer = true
                })
                TabButton(title: "Diet/Water", imageName: "drop.fill", action: onDietWaterPlan)
                TabButton(title: "Exercise", imageName: "figure.walk", action: {
                    showExerciseAnalyzer = true
                })
                TabButton(title: "Meal Plan", imageName: "list.bullet", action: {
                    showMealScan = true
                })
            }
            .padding(.bottom, 20)
            .background(Color.gray.opacity(0.2))
        }
        .edgesIgnoringSafeArea(.bottom)
        .sheet(isPresented: $showNutritionAnalyzer) {
            NutritionAnalyzerView()
        }
        .sheet(isPresented: $showExerciseAnalyzer) {
            ExerciseAnalyzerView()
        }
        .sheet(isPresented: $showMealScan) {
            MealScanView()
        }
    }
}

struct TabButton: View {
    let title: String
    let imageName: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: imageName)
                    .font(.system(size: 30)) // Increased size from 24 to 30
                    .foregroundColor(.blue) // Added color for better visibility
                Text(title)
                    .font(.caption)
            }
        }
        .foregroundColor(.primary)
        .frame(maxWidth: .infinity)
    }
}
