//
//  SceneDelegate.swift
//  HealthTracker
//
//  Created by Swarasai Mulagari on 10/9/24.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Ensure that we have a UIWindowScene
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // Create the SwiftUI view that provides the splash screen
        let splashScreenView = SplashScreenView()

        // Create a UIWindow using windowScene
        let window = UIWindow(windowScene: windowScene)

        // Set the rootViewController to a UIHostingController with the SwiftUI view
        window.rootViewController = UIHostingController(rootView: splashScreenView)
        
        // Make the window visible
        self.window = window
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
    }
}
