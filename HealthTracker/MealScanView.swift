import SwiftUI
import CoreML
import Vision
import UIKit

struct MealScanView: View {
    @State private var image: UIImage?
    @State private var resultText: String = ""
    @State private var isImageCaptured: Bool = false
    @State private var isLoading: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var showResults: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 300)
                        .cornerRadius(10)
                }
                Button(action: {
                    self.showImagePicker = true
                }) {
                    Text("Capture Meal Image")
                        .font(.headline)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                .sheet(isPresented: $showImagePicker) {
                    ImagePicker(sourceType: .camera, selectedImage: $image) { capturedImage in
                        if let capturedImage = capturedImage {
                            analyzeImage(capturedImage)
                        }
                    }
                }
                
                if isLoading {
                    ProgressView("Analyzing...")
                }
            }
            .padding()
            .navigationBarTitle("Meal Scan", displayMode: .inline)
            .navigationBarItems(leading: Button("Close") {
                presentationMode.wrappedValue.dismiss()
            })
            .fullScreenCover(isPresented: $showResults) {
                if let image = image {
                    ResultView(resultText: resultText, capturedImage: image) {
                        showResults = false
                        self.image = nil
                        resultText = ""
                    }
                }
            }
        }
    }
    
    private func analyzeImage(_ image: UIImage) {
        guard let ciImage = CIImage(image: image) else {
            showResult(resultText: "Failed to process image.")
            return
        }
        
        isLoading = true
        
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                let config = MLModelConfiguration()
                let model = try VNCoreMLModel(for: mealscan(configuration: config).model)
                
                let request = VNCoreMLRequest(model: model) { request, error in
                    if let error = error {
                        DispatchQueue.main.async {
                            self.isLoading = false
                            self.showResult(resultText: "Error analyzing image: \(error.localizedDescription)")
                        }
                        return
                    }
                    
                    guard let results = request.results as? [VNClassificationObservation] else {
                        DispatchQueue.main.async {
                            self.isLoading = false
                            self.showResult(resultText: "Unexpected result type from VNCoreMLRequest")
                        }
                        return
                    }
                    
                    if let topResult = results.first {
                        let foodItem = topResult.identifier
                        let confidence = topResult.confidence
                        print("Detected food: \(foodItem) with confidence: \(confidence)")
                        let message = self.getMessage(for: foodItem)
                        DispatchQueue.main.async {
                            self.isLoading = false
                            self.showResult(resultText: "Detected: \(foodItem)\n\n\(message)")
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.isLoading = false
                            self.showResult(resultText: "Unable to classify the image.")
                        }
                    }
                }
                
                let handler = VNImageRequestHandler(ciImage: ciImage, orientation: .up)
                try handler.perform([request])
            } catch {
                print("Error setting up Vision with CoreML: \(error)")
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.showResult(resultText: "Error setting up image analysis.")
                }
            }
        }
    }
    
    private func showResult(resultText: String) {
        self.resultText = resultText
        self.showResults = true
    }
    
    private func getMessage(for condition: String) -> String {
        switch condition {
        case "Bread":
            return "Bread detected. While it provides carbohydrates for energy, opt for whole grain varieties for more fiber and nutrients. Moderation is key for weight management."
        case "Dairy product":
            return "Dairy product found. Good source of calcium and protein. If you're looking to reduce fat intake, consider low-fat options. Dairy can support bone health and muscle recovery."
        case "Dessert":
            return "Dessert identified. While enjoyable, desserts are often high in sugar and calories. Consume in moderation if you're focusing on weight loss or maintaining a balanced diet."
        case "Egg":
            return "Eggs detected! Excellent source of high-quality protein and various nutrients. They can support muscle building and provide satiety, aiding in weight management."
        case "Fried food":
            return "Fried food spotted. While tasty, fried foods are typically high in calories and unhealthy fats. Limit consumption for better heart health and to support weight loss goals."
        case "Meat":
            return "Meat identified. Good source of protein and iron. Lean meats can support muscle growth and repair. However, consider portion sizes and preparation methods for overall health."
        case "Noodles-Pasta":
            return "Noodles or pasta detected. Provides carbohydrates for energy. Choose whole grain options for more fiber and nutrients. Be mindful of portion sizes if managing weight."
        case "Rice":
            return "Rice found on your plate. A staple carbohydrate source. Brown rice offers more fiber and nutrients compared to white rice. Portion control is important for weight management."
        case "Seafood":
            return "Seafood detected. Excellent source of lean protein and omega-3 fatty acids. Supports heart health and can aid in maintaining a healthy weight. Great choice for most fitness goals."
        case "Soup":
            return "Soup identified. Can be a nutritious, low-calorie option depending on ingredients. Broth-based soups can help with hydration and feeling full, supporting weight management."
        case "Vegetable-Fruit":
            return "Vegetables or fruits detected. Excellent choice! Rich in vitamins, minerals, and fiber. Low in calories and high in nutrients, they support overall health and can aid in weight management."
        default:
            return "This food item may not directly align with common fitness goals. Remember, a balanced diet with a variety of nutrients is key to supporting your overall health and fitness."
        }
    }
}
