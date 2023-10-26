//
//  AuthService.swift
//  Atty
//
//  Created by Nikita Melnikov on 24.10.2023.
//

import Foundation
import FirebaseAuth
import UIKit

class AuthService {
    
    static let shared = AuthService()
    
    private init() {}
    
    func createUser(name: String, email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                Alert.shared.showAlert(title: DS.AlertMessages.attention, message: error.localizedDescription)
            } else {
                self.signIn(email: email, password: password)
                self.changeVCAuth(vc: NavigateTabBarController())
            }
        }
    }
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            self?.changeVCAuth(vc: NavigateTabBarController())
        }
    }
    
    func logout() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            AuthService.shared.changeVCAuth(vc: AuthVC())
            
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    func changeVCAuth(vc: UIViewController) {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = scene.windows.first {
                UIView.transition(with: window, duration: 0.6, options: .transitionCrossDissolve, animations: {
                    if let previousController = window.rootViewController {
                        previousController.dismiss(animated: false, completion: nil)
                    }
                    let nav = UINavigationController(rootViewController: vc)
                    nav.modalPresentationStyle = .fullScreen
                    window.rootViewController = nav
                }, completion: nil)
            }
        }
    }
    
    func resetPassword(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
        
        }
    }
}



