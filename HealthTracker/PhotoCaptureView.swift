//
//  PhotoCaptureView.swift
//  HealthTracker
//
//  Created by Swarasai Mulagari on 10/9/24.
//

import SwiftUI
import UIKit

struct PhotoCaptureView: UIViewControllerRepresentable {
    var onImageCaptured: (UIImage?) -> Void  // Closure to pass the captured image to the parent

    // This makes the coordinator that handles the interaction between UIKit and SwiftUI
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator

        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
            picker.cameraDevice = .rear

            // Check and fallback to supported camera modes
            if UIImagePickerController.isCameraDeviceAvailable(.rear) {
                picker.cameraDevice = .rear  // Use rear camera
            } else if UIImagePickerController.isCameraDeviceAvailable(.front) {
                picker.cameraDevice = .front  // Fallback to front camera if rear is unavailable
            }
        } else {
            // If the camera is not available, fallback to photo library
            print("Camera not available, falling back to photo library")
            picker.sourceType = .photoLibrary
        }

        return picker
    }

    // No need to update the UIViewController in this case
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    // Coordinator class to handle UIImagePickerControllerDelegate and UINavigationControllerDelegate
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: PhotoCaptureView  // Reference to the parent view (PhotoCaptureView)

        // Initialize the Coordinator with a reference to the parent view
        init(_ parent: PhotoCaptureView) {
            self.parent = parent  // Now 'parent' refers to the PhotoCaptureView
        }

        // This method is triggered when an image is picked
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let image = info[.originalImage] as? UIImage
            print("Image Captured: \(String(describing: image))")  // Debugging: Image captured
            parent.onImageCaptured(image)  // Call the closure to pass the image back to the parent

            // Dismiss the picker after capturing the image
            picker.dismiss(animated: true, completion: nil)
        }

        // This method is triggered when the user cancels the picker
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
    }
}

