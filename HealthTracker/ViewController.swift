//
//  ViewController.swift
//  HealthTracker
//
//  Created by Swarasai Mulagari on 10/9/24.
//

import UIKit
import SwiftUI
import CoreML

class ViewController: UIViewController {
    private var formHostingController: UIHostingController<HealthFormView>?
    private var optionsHostingController: UIHostingController<OptionsView>?
    private var photoCaptureHostingController: UIHostingController<PhotoCaptureView>?
    private var splashScreenHostingController: UIHostingController<SplashScreenView>?
    private var ingredientsCheckHostingController: UIHostingController<IngredientsCheckView>?

    private var extractedText: String = "" // To store extracted text from the image
    private var skinCondition: String = "" // To store the identified skin condition

    private let resultLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "MarkerFelt-Wide", size: 24)
        label.numberOfLines = 0
        label.textColor = UIColor(red: 0.0, green: 0.0, blue: 0.5, alpha: 1) // Navy blue color
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
        button.addTarget(ViewController.self, action: #selector(backButtonTapped), for: .touchUpInside)
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
        button.addTarget(ViewController.self, action: #selector(instructionsCheckButtonTapped), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

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
        let formView = HealthFormView(onSubmit: { [weak self] currentWeight, goalWeight, wantsClearSkin, extractedText, skinCondition in
            print("Current Weight: \(currentWeight), Goal Weight: \(goalWeight), Wants Clear Skin: \(wantsClearSkin)")
            self?.navigateToOptions(currentWeight: currentWeight, goalWeight: goalWeight, wantsClearSkin: wantsClearSkin, extractedText: extractedText, skinCondition: skinCondition)
        })

        formHostingController = UIHostingController(rootView: formView)
        if let hostingController = formHostingController {
            addChild(hostingController)
            hostingController.view.frame = view.bounds
            view.addSubview(hostingController.view)
            hostingController.didMove(toParent: self)
        }
    }

    private func navigateToOptions(currentWeight: String, goalWeight: String, wantsClearSkin: Bool, extractedText: String, skinCondition: String) {
        formHostingController?.view.removeFromSuperview()
        formHostingController?.removeFromParent()

        let optionsView = OptionsView(
            currentWeight: currentWeight,
            goalWeight: goalWeight,
            wantsClearSkin: wantsClearSkin,
            onIngredientCheck: { [weak self] in
                self?.navigateToIngredientCheck()  // Navigate to ingredient check
            },
            onMealPlan: {
                // Logic for meal plan navigation
            },
            onDietWaterPlan: {
                // Logic for diet/water plan navigation
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
        
        // Present the ingredients check view
        ingredientsCheckHostingController = UIHostingController(rootView: ingredientsCheckView)
        if let hostingController = ingredientsCheckHostingController {
            present(hostingController, animated: true, completion: nil)
        }
    }

    private func setupUIElements() {
        view.addSubview(resultLabel)
        view.addSubview(backButton)
        view.addSubview(instructionsCheckButton)
        setupConstraints()
    }
    
    private func setupConstraints() {
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        instructionsCheckButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            resultLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            resultLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 300),
            
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backButton.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 100),
            backButton.heightAnchor.constraint(equalToConstant: 44),
            
            instructionsCheckButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            instructionsCheckButton.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 20),
            instructionsCheckButton.widthAnchor.constraint(equalToConstant: 200),
            instructionsCheckButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func navigateToPhotoCapture() {
        let photoCaptureView = PhotoCaptureView(onImageCaptured: { [weak self] image in
            guard let image = image else {
                print("No image captured.")  // Handle when no image is captured
                self?.showResult(resultText: "No image captured.")
                return
            }

            print("Image was captured, starting analysis...")  // Debugging: Image captured
            // Perform the analysis after the image is captured
            DispatchQueue.global(qos: .userInitiated).async {
                self?.analyzeImage(image: image)  // Call analyzeImage, which will show the result
            }
        })

        let photoCaptureHostingController = UIHostingController(rootView: photoCaptureView)

        // Clean up any previous hosting controllers before showing the new one
        self.clearPreviousHostingControllers()

        // Present the photo capture view
        self.present(photoCaptureHostingController, animated: true, completion: nil)
    }

    private func analyzeImage(image: UIImage) {
        print("Analyzing image: \(image)")  // Debugging: Start image analysis

        // Resize and convert the image to a pixel buffer for model input
        guard let resizedImage = image.resize(size: CGSize(width: 224, height: 224)),
              let pixelBuffer = resizedImage.getCVPixelBuffer() else {
            DispatchQueue.main.async {
                print("Failed to process image.")  // Debugging: Failed to process image
                self.showResult(resultText: "Failed to process image.")
            }
            return
        }

        // Assuming your Core ML model Shine_Up_6 is ready to use
        do {
            let config = MLModelConfiguration()
            let model = try Shine_Up_6(configuration: config)
            let input = Shine_Up_6Input(image: pixelBuffer)

            let output = try model.prediction(input: input)
            let message = self.getMessage(for: output.target)

            DispatchQueue.main.async { [weak self] in
                print("Analysis complete: \(message)")  // Debugging: Analysis complete

                // Present the analysis result view
                self?.presentAnalysisResult(analysisResult: message, capturedImage: image)
            }
        } catch {
            print("Error during image analysis: \(error.localizedDescription)")
            DispatchQueue.main.async {
                self.showResult(resultText: "Error analyzing image.")
            }
        }
    }
    
    private func presentAnalysisResult(analysisResult: String, capturedImage: UIImage) {
        let analysisResultView = AnalysisResultView(
            resultText: analysisResult,
            capturedImage: capturedImage,
            onRetakePhoto: { [weak self] in
                self?.navigateToPhotoCapture()  // Allow user to retake photo
            },
            onGoToIngredientsCheck: { [weak self] in
                self?.navigateToIngredientsCheck()  // Allow user to go to ingredients check view
            }
        )

        let resultHostingController = UIHostingController(rootView: analysisResultView)

        // Remove any lingering hosting controllers to avoid conflicts
        self.clearPreviousHostingControllers()

        // Present the analysis result view directly
        self.present(resultHostingController, animated: true, completion: nil)
    }

    private func clearPreviousHostingControllers() {
        if let optionsHostingController = optionsHostingController {
            optionsHostingController.view.removeFromSuperview()
            optionsHostingController.removeFromParent()
            self.optionsHostingController = nil
        }
        
        if let photoCaptureHostingController = photoCaptureHostingController {
            photoCaptureHostingController.view.removeFromSuperview()
            photoCaptureHostingController.removeFromParent()
            self.photoCaptureHostingController = nil
        }

        if let formHostingController = formHostingController {
            formHostingController.view.removeFromSuperview()
            formHostingController.removeFromParent()
            self.formHostingController = nil
        }
    }


    private func showAnalysisResult(analysisResult: String, capturedImage: UIImage) {
        // Remove any existing hosting controllers before presenting the result
        if let optionsHostingController = optionsHostingController {
            optionsHostingController.view.removeFromSuperview()
            optionsHostingController.removeFromParent()
            self.optionsHostingController = nil
        }
        
        // Create and present the analysis result view
        let analysisResultView = AnalysisResultView(
            resultText: analysisResult,
            capturedImage: capturedImage,
            onRetakePhoto: { [weak self] in
                self?.navigateToPhotoCapture()  // Allow user to retake photo
            },
            onGoToIngredientsCheck: { [weak self] in
                self?.navigateToIngredientsCheck()  // Allow user to go to ingredients check view
            }
        )

        // Dismiss all existing view controllers before showing the analysis result
        self.dismiss(animated: false) { [weak self] in
            let resultHostingController = UIHostingController(rootView: analysisResultView)
            self?.present(resultHostingController, animated: true, completion: nil)
        }
    }

    private func navigateToIngredientsCheck() {
        let ingredientsCheckView = IngredientsCheckView(extractedText: extractedText, skinCondition: skinCondition)
        ingredientsCheckHostingController = UIHostingController(rootView: ingredientsCheckView)

        if let hostingController = ingredientsCheckHostingController {
            present(hostingController, animated: true, completion: nil)
        }
    }

    private func showResult(resultText: String) {
        DispatchQueue.main.async {
            self.resultLabel.text = resultText // Update the result label with the analysis result
            self.resultLabel.isHidden = false  // Make sure the label is visible
            
            // Show the necessary buttons after displaying the result
            self.instructionsCheckButton.isHidden = false
            self.backButton.isHidden = false
        }
    }

    private func getMessage(for condition: String) -> String {
        switch condition.lowercased() {
        case "acne":
            return "This may be acne. Consider a gentle cleanser and moisturizer."
        case "carcinoma":
            return "This might be carcinoma. Please consult a dermatologist."
        case "eczema":
            return "This seems like eczema. Moisturizing may alleviate symptoms."
        case "keratosis":
            return "This looks like keratosis. A dermatologist can provide advice."
        case "milia":
            return "This appears to be milia. Consider exfoliation techniques."
        case "rosacea":
            return "This may be rosacea. A gentle skincare routine can help."
        default:
            return "Unable to identify the condition. Please consult a professional."
        }
    }

    @objc private func backButtonTapped() {
        // Implement back navigation logic here
        print("Back button tapped")
    }

    @objc private func instructionsCheckButtonTapped() {
        let ingredientsCheckView = IngredientsCheckView(extractedText: extractedText, skinCondition: skinCondition)
        ingredientsCheckHostingController = UIHostingController(rootView: ingredientsCheckView)

        if let hostingController = ingredientsCheckHostingController {
            present(hostingController, animated: true, completion: nil)
        }
    }
}
