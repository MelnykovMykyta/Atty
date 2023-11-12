//
//  FirebaseAuthService.swift
//  Atty
//
//  Created by Nikita Melnikov on 27.10.2023.
//

import Foundation
import FirebaseAuth
import UIKit

class FirebaseAuthService {
    
    static let shared = FirebaseAuthService()
    
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
            if let authResult = authResult {
                AuthViewModel.currentUserEmail = authResult.user.email ?? ""
                self?.changeVCAuth(vc: NavigateTabBarController())
            } else {
                Alert.shared.showAlert(title: "Упс", message: "Помилка авторизації")
            }
        }
    }
    
    func logout() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.changeVCAuth(vc: SignInVC())
            
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
                    let nav = NavigationBarController(rootViewController: vc)
                    nav.modalPresentationStyle = .fullScreen
                    window.rootViewController = nav
                }, completion: nil)
            }
        }
    }
    
    func resetPassword(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email)
    }
}
