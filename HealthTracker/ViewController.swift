import UIKit
import SwiftUI
import CoreML

class ViewController: UIViewController {
    private var formHostingController: UIHostingController<HealthFormView>?
    private var optionsHostingController: UIHostingController<OptionsView>?
    private var splashScreenHostingController: UIHostingController<SplashScreenView>?
    private var ingredientsCheckHostingController: UIHostingController<IngredientsCheckView>?

    private var extractedText: String = ""
    private var skinCondition: String = ""

    private let resultLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "MarkerFelt-Wide", size: 24)
        label.numberOfLines = 0
        label.textColor = UIColor(red: 0.0, green: 0.0, blue: 0.5, alpha: 1)
        label.text = ""
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Back", for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 18)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    private let instructionsCheckButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Ingredients Check", for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 18)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.systemGreen
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(instructionsCheckButtonTapped), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.784, green: 0.894, blue: 0.937, alpha: 1)
        
        showSplashScreen {
            self.showHealthForm()
            self.setupUIElements()
        }
    }
    
    private func showSplashScreen(completion: @escaping () -> Void) {
        let splashScreenView = SplashScreenView()
        
        splashScreenHostingController = UIHostingController(rootView: splashScreenView)
        
        if let hostingController = splashScreenHostingController {
            addChild(hostingController)
            hostingController.view.frame = view.bounds
            view.addSubview(hostingController.view)
            hostingController.didMove(toParent: self)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.splashScreenHostingController?.view.removeFromSuperview()
            self.splashScreenHostingController?.removeFromParent()
            completion()
        }
    }

    private func showHealthForm() {
        let formView = HealthFormView { currentWeight, goalWeight, wantsClearSkin, dailyWaterIntake, exerciseHours, sleepHours in
            print("Current Weight: \(currentWeight)")
            print("Goal Weight: \(goalWeight)")
            print("Wants Clear Skin: \(wantsClearSkin)")
            print("Daily Water Intake: \(dailyWaterIntake)")
            print("Exercise Hours: \(exerciseHours)")
            print("Sleep Hours: \(sleepHours)")

            self.navigateToOptions(currentWeight: currentWeight, goalWeight: goalWeight, wantsClearSkin: wantsClearSkin, dailyWaterIntake: dailyWaterIntake, exerciseHours: exerciseHours, sleepHours: sleepHours)
        }

        formHostingController = UIHostingController(rootView: formView)
        if let hostingController = formHostingController {
            addChild(hostingController)
            hostingController.view.frame = view.bounds
            view.addSubview(hostingController.view)
            hostingController.didMove(toParent: self)
        }
    }

    private func navigateToOptions(currentWeight: String, goalWeight: String, wantsClearSkin: String, dailyWaterIntake: String, exerciseHours: String, sleepHours: String) {
        let optionsView = OptionsView(
            currentWeight: currentWeight,
            goalWeight: goalWeight,
            wantsClearSkin: wantsClearSkin,
            dailyWaterIntake: dailyWaterIntake,
            exerciseHours: exerciseHours,
            sleepHours: sleepHours,
            onIngredientCheck: {
                self.navigateToIngredientCheck()
            },
            onMealPlan: {
                // Handle Meal Plan action
                print("Meal Plan tapped")
            },
            onDietWaterPlan: {
                // Handle Diet/Water Plan action
                print("Diet/Water Plan tapped")
            }
        )

        optionsHostingController = UIHostingController(rootView: optionsView)
        if let hostingController = optionsHostingController {
            addChild(hostingController)
            hostingController.view.frame = view.bounds
            view.addSubview(hostingController.view)
            hostingController.didMove(toParent: self)
        }
    }

    private func navigateToIngredientCheck() {
        let ingredientsCheckView = IngredientsCheckView(extractedText: extractedText, skinCondition: skinCondition)
        
        ingredientsCheckHostingController = UIHostingController(rootView: ingredientsCheckView)
        if let hostingController = ingredientsCheckHostingController {
            present(hostingController, animated: true, completion: nil)
        }
    }

    private func setupUIElements() {
        view.addSubview(resultLabel)
        view.addSubview(backButton)
        view.addSubview(instructionsCheckButton)
        
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        instructionsCheckButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150),
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backButton.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 100),
            instructionsCheckButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            instructionsCheckButton.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 20),
            instructionsCheckButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    @objc private func backButtonTapped() {
        print("Back button tapped")
        // Add functionality to go back
    }
    
    @objc private func instructionsCheckButtonTapped() {
        print("Ingredients Check button tapped")
        navigateToIngredientCheck()
    }
}
