//
//  SceneDelegate.swift
//  Atty
//
//  Created by Nikita Melnikov on 20.10.2023.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        self.setupWindow(with: scene)
        self.checkAuthentication()
    }
    
    private func setupWindow(with scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        self.window?.makeKeyAndVisible()
        self.window?.overrideUserInterfaceStyle = .dark
        self.window?.backgroundColor = DS.Colors.mainBackgroundColor
    }
    
    private func checkAuthentication() {
        
        if Auth.auth().currentUser == nil {
            FirebaseAuthService.shared.changeVCAuth(vc: SignInVC())
        } else {
            FirebaseAuthService.shared.changeVCAuth(vc: NavigateTabBarController())
        }
    }
}

