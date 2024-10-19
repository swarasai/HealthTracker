//
//  AnalysisView.swift
//  HealthTracker
//
//  Created by Swarasai Mulagari on 10/16/24.
//

import SwiftUI

struct AnalysisResultView: View {
    var resultText: String
    var capturedImage: UIImage
    var onRetakePhoto: () -> Void
    var onGoToIngredientsCheck: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text(resultText)
                .font(.title)
                .multilineTextAlignment(.center)
                .padding()

            Image(uiImage: capturedImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 10)

            // Button to retake photo
            Button(action: onRetakePhoto) {
                Text("Retake Photo")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)

            // Button to go to ingredients check
            Button(action: onGoToIngredientsCheck) {
                Text("Go to Ingredients Check")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
        }
        .padding()
    }
}
