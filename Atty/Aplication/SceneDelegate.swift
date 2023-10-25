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
    
    public func checkAuthentication() {

        if Auth.auth().currentUser == nil {
            self.goToController(with: AuthVC())
        } else {
            self.goToController(with: MainVC())
        }
    }
    
    
    private func goToController(with viewController: UIViewController) {
        DispatchQueue.main.async { [weak self] in
            UIView.animate(withDuration: 0.3) {
                self?.window?.layer.opacity = 0
                
            } completion: { [weak self] _ in
                
                let nav = UINavigationController(rootViewController: viewController)
                nav.modalPresentationStyle = .fullScreen
                self?.window?.rootViewController = nav
                
                UIView.animate(withDuration: 0.3) { [weak self] in
                    self?.window?.layer.opacity = 1
                }
            }
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) { }
    
    func sceneDidBecomeActive(_ scene: UIScene) { }
    
    func sceneWillResignActive(_ scene: UIScene) { }
    
    func sceneWillEnterForeground(_ scene: UIScene) { }
    
    func sceneDidEnterBackground(_ scene: UIScene) { }
}

