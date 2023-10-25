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
            }
        }
    }
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
        }
    }
}
