//
//  AuthViewModel.swift
//  Atty
//
//  Created by Nikita Melnikov on 24.10.2023.
//

import Foundation
import UIKit

class AuthViewModel {
    
    func signInUser(view: UIView) {
        guard let view = view as? SignInView else { return }
        guard let email = view.userEmailTF.text, let password = view.userPasswordTF.text else { return }
        let checkTF = checkTextFields(textFields: [email, password])
        let checkEmail = checkEmail(email: email)
        
        if checkTF && checkEmail {
            FirebaseAuthService.shared.signIn(email: email, password: password)
        }
    }
    
    func signUpUser(view: UIView) {
        guard let view = view as? SignUpView else { return }
        guard let name = view.userNameTF.text, let email = view.userEmailTF.text, let password = view.userPasswordTF.text else { return }
        
        let checkTF = checkTextFields(textFields: [name, email, password])
        let checkEmail = checkEmail(email: email)
        
        if checkTF && checkEmail {
            FirebaseAuthService.shared.createUser(name: name, email: email, password: password)
        }
    }
    
    func forgotPassword(view: UIView) {
        
        guard let view = view as? ResetPasswordView else { return }
        guard let email = view.userEmailTF.text else { return }
        
        let checkTF = checkTextFields(textFields: [email])
        let checkEmail = checkEmail(email: email)
        
        if checkTF && checkEmail {
            FirebaseAuthService.shared.resetPassword(email: email)
            FirebaseAuthService.shared.changeVCAuth(vc: AuthVC())
            Alert.shared.showAlert(title: DS.AlertMessages.attention, message: DS.AlertMessages.forgotPassword)
        }
    }
    
    func checkTextFields(textFields: [String]) -> Bool {
        let emptyTextFieldsValue = textFields.filter { $0.isEmpty }
        
        if emptyTextFieldsValue.isEmpty {
            return true
        } else {
            Alert.shared.showAlert(title: DS.AlertMessages.attention, message: DS.AlertMessages.emptyLine)
            return false
        }
    }
    
    func checkEmail(email: String) -> Bool {
        let checkEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailChecker = NSPredicate(format: "SELF MATCHES %@", checkEmail)
        guard emailChecker.evaluate(with: email) else {
            Alert.shared.showAlert(title: DS.AlertMessages.attention, message: DS.AlertMessages.wrongEmail)
            return false
        }
        return true
    }
}
