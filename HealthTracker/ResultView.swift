import SwiftUI

struct ResultView: View {
    var resultText: String
    var capturedImage: UIImage
    var onBack: () -> Void

    var body: some View {
        ScrollView {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    Image(uiImage: capturedImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 300)
                        .cornerRadius(10)

                    Text(formatResultText(resultText))
                        .font(.custom("AvenirNext-Regular", size: 18))
                        .padding()
                        .multilineTextAlignment(.center)
                    
                    Button(action: onBack) {
                        Text("Back to Home")
                            .font(.custom("AvenirNext-Bold", size: 18))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.orange)
                            .cornerRadius(8)
                    }
                }
                .padding()
            }
        }
    }
    
    private func formatResultText(_ text: String) -> AttributedString {
        var attributedString = AttributedString(text)
        
        let keyTerms = ["Bread", "Dairy product", "Dessert", "Egg", "Fried food", "Meat", "Noodles-Pasta", "Rice", "Seafood", "Soup", "Vegetable-Fruit", "Detected"]
        
        for term in keyTerms {
            if let range = attributedString.range(of: term) {
                attributedString[range].foregroundColor = .orange
                attributedString[range].font = .custom("AvenirNext-Bold", size: 18)
            }
        }
        
        return attributedString
    }
}
