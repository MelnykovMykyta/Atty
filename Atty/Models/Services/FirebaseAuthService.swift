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
    
    func createUser(name: String, userStatus: String, email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                Alert.showAlert(title: DS.AlertMessages.attention, message: error.localizedDescription)
            } else {
                let newUser = User(email: email, name: name, status: userStatus)
                RealmDBService.addObject(object: newUser)
                self.signIn(email: email, password: password)
            }
        }
    }
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard self != nil else { return }
            if let authResult = authResult {
                AuthViewModel.resetAllCurrentParameters()
                AuthViewModel.currentUserEmail = authResult.user.email ?? ""
                self?.checkUserDataOnDevice()
            } else {
                Alert.showAlert(title: "Упс", message: "Помилка авторизації")
            }
        }
    }
    
    func checkUserDataOnDevice() {
        let user = RealmDBService.getObjects(User.self)
            .filter { $0.email == Auth.auth().currentUser?.email }.first
        
        if user != nil {
            AuthViewModel.currentUserEmail = Auth.auth().currentUser?.email ?? ""
            FirebaseAuthService.shared.changeVCAuth(vc: NavigateTabBarController())
        } else {
            FirebaseAuthService.shared.changeVCAuth(vc: SignUpVC())
            Alert.showAlert(title: "Відстуні дані", message: "Пройдіть реєстрацію")
        }
    }
    
    func logout() {
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
            self.changeVCAuth(vc: SignInVC())
            AuthViewModel.resetAllCurrentParameters()
            
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
