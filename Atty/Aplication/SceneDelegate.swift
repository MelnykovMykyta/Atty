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
            FirebaseAuthService.shared.changeVCAuth(vc: AuthVC())
        } else {
            FirebaseAuthService.shared.changeVCAuth(vc: NavigateTabBarController())
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) { }
    
    func sceneDidBecomeActive(_ scene: UIScene) { }
    
    func sceneWillResignActive(_ scene: UIScene) { }
    
    func sceneWillEnterForeground(_ scene: UIScene) { }
    
    func sceneDidEnterBackground(_ scene: UIScene) { }
}

