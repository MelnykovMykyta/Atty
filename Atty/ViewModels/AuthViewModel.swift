//
//  AuthViewModel.swift
//  Atty
//
//  Created by Nikita Melnikov on 24.10.2023.
//

import Foundation
import UIKit

class AuthViewModel {
    
    static var currentUserEmail = String()
    
    static func signInUser(email: String, password: String) {
        let checkTF = checkTextFields(textFields: [email, password])
        let checkEmail = checkEmail(email: email)
        
        if checkTF && checkEmail {
            FirebaseAuthService.shared.signIn(email: email, password: password)
        }
    }
    
    static func signUpUser(name: String, email: String, password: String) {
        
        let checkTF = checkTextFields(textFields: [name, email, password])
        let checkEmail = checkEmail(email: email)
        
        if checkTF && checkEmail {
            FirebaseAuthService.shared.createUser(name: name, email: email, password: password)
        }
    }
    
    static func forgotPassword(email: String) {
        
        let checkTF = checkTextFields(textFields: [email])
        let checkEmail = checkEmail(email: email)
        
        if checkTF && checkEmail {
            FirebaseAuthService.shared.resetPassword(email: email)
            FirebaseAuthService.shared.changeVCAuth(vc: SignInVC())
            Alert.shared.showAlert(title: DS.AlertMessages.attention, message: DS.AlertMessages.forgotPassword)
        }
    }
    
    static func checkTextFields(textFields: [String]) -> Bool {
        let emptyTextFieldsValue = textFields.filter { $0.isEmpty }
        
        if emptyTextFieldsValue.isEmpty {
            return true
        } else {
            Alert.shared.showAlert(title: DS.AlertMessages.attention, message: DS.AlertMessages.emptyLine)
            return false
        }
    }
    
    static func checkEmail(email: String) -> Bool {
        let checkEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailChecker = NSPredicate(format: "SELF MATCHES %@", checkEmail)
        guard emailChecker.evaluate(with: email) else {
            Alert.shared.showAlert(title: DS.AlertMessages.attention, message: DS.AlertMessages.wrongEmail)
            return false
        }
        return true
    }
}
