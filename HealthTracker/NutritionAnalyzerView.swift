//
//  NutritionAnalyzerView.swift
//  HealthTracker
//
//  Created by Swarasai Mulagari on 10/19/24.
//

import SwiftUI
import Vision
import VisionKit

struct NutritionAnalyzerView: View {
    @State private var showScanner = false
    @State private var scannedText = ""
    @State private var analysisResult = ""

    var body: some View {
        VStack {
            Text("Nutrition Analyzer")
                .font(.largeTitle)
                .padding()

            Button("Scan Nutrition Label") {
                showScanner = true
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)

            if !scannedText.isEmpty {
                Text("Scanned Text:")
                    .font(.headline)
                    .padding(.top)
                ScrollView {
                    Text(scannedText)
                        .padding()
                }
            }

            if !analysisResult.isEmpty {
                Text("Analysis Result:")
                    .font(.headline)
                    .padding(.top)
                Text(analysisResult)
                    .padding()
            }
        }
        .sheet(isPresented: $showScanner) {
            ScannerView(scannedText: $scannedText, analysisResult: $analysisResult)
        }
    }
}

struct ScannerView: UIViewControllerRepresentable {
    @Binding var scannedText: String
    @Binding var analysisResult: String

    func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
        let scannerViewController = VNDocumentCameraViewController()
        scannerViewController.delegate = context.coordinator
        return scannerViewController
    }

    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        var parent: ScannerView

        init(_ parent: ScannerView) {
            self.parent = parent
        }

        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            guard scan.pageCount >= 1 else {
                controller.dismiss(animated: true)
                return
            }

            let image = scan.imageOfPage(at: 0)
            let textRecognizer = TextRecognizer()
            textRecognizer.recognizeText(from: image) { result in
                DispatchQueue.main.async {
                    self.parent.scannedText = result
                    self.parent.analysisResult = self.analyzeNutrition(text: result)
                    controller.dismiss(animated: true)
                }
            }
        }

        func analyzeNutrition(text: String) -> String {
            let lines = text.lowercased().components(separatedBy: .newlines)
            var calories = 0
            var fat = 0
            var cholesterol = 0
            var sodium = 0
            var carbs = 0
            var protein = 0

            for line in lines {
                if line.contains("calories") {
                    calories = extractNumber(from: line)
                } else if line.contains("fat") {
                    fat = extractNumber(from: line)
                } else if line.contains("cholesterol") {
                    cholesterol = extractNumber(from: line)
                } else if line.contains("sodium") {
                    sodium = extractNumber(from: line)
                } else if line.contains("carbohydrate") {
                    carbs = extractNumber(from: line)
                } else if line.contains("protein") {
                    protein = extractNumber(from: line)
                }
            }

            return generateAnalysis(calories: calories, fat: fat, cholesterol: cholesterol, sodium: sodium, carbs: carbs, protein: protein)
        }

        func extractNumber(from string: String) -> Int {
            let numbers = string.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
            return Int(numbers) ?? 0
        }

        func generateAnalysis(calories: Int, fat: Int, cholesterol: Int, sodium: Int, carbs: Int, protein: Int) -> String {
            var analysis = "Based on the nutritional information:\n\n"

            if calories > 300 {
                analysis += "- This food is high in calories. Consider portion control.\n"
            } else {
                analysis += "- The calorie content is moderate to low.\n"
            }

            if fat > 15 {
                analysis += "- The fat content is high. Be mindful of your daily fat intake.\n"
            } else {
                analysis += "- The fat content is within a reasonable range.\n"
            }

            if cholesterol > 50 {
                analysis += "- Cholesterol levels are high. This may not be suitable for those watching their cholesterol intake.\n"
            } else {
                analysis += "- Cholesterol levels are moderate to low.\n"
            }

            if sodium > 500 {
                analysis += "- This food is high in sodium. Be cautious if you're on a low-sodium diet.\n"
            } else {
                analysis += "- Sodium levels are within an acceptable range.\n"
            }

            if carbs > 50 {
                analysis += "- Carbohydrate content is high. Consider this if you're watching your carb intake.\n"
            } else {
                analysis += "- Carbohydrate content is moderate to low.\n"
            }

            if protein > 15 {
                analysis += "- This food is a good source of protein.\n"
            } else {
                analysis += "- Protein content is moderate to low.\n"
            }

            let healthyScore = (calories <= 300 ? 1 : 0) + (fat <= 15 ? 1 : 0) + (cholesterol <= 50 ? 1 : 0) +
                               (sodium <= 500 ? 1 : 0) + (carbs <= 50 ? 1 : 0) + (protein > 15 ? 1 : 0)

            if healthyScore >= 4 {
                analysis += "\nOverall, this food item appears to be relatively healthy. However, always consider your individual dietary needs and consult with a nutritionist if needed."
            } else {
                analysis += "\nOverall, this food item may not be the healthiest choice. Consider it as an occasional treat rather than a regular part of your diet."
            }

            return analysis
        }
    }
}

class TextRecognizer {
    func recognizeText(from image: UIImage, completion: @escaping (String) -> Void) {
        guard let cgImage = image.cgImage else {
            completion("")
            return
        }

        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        let request = VNRecognizeTextRequest { request, error in
            guard let observations = request.results as? [VNRecognizedTextObservation],
                  error == nil else {
                completion("")
                return
            }

            let recognizedStrings = observations.compactMap { observation in
                observation.topCandidates(1).first?.string
            }

            let result = recognizedStrings.joined(separator: "\n")
            completion(result)
        }

        do {
            try handler.perform([request])
        } catch {
            print("Failed to perform OCR: \(error)")
            completion("")
        }
    }
}
