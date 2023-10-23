//
//  AuthVC.swift
//  Atty
//
//  Created by Nikita Melnikov on 23.10.2023.
//

import Foundation
import UIKit
import SnapKit

class AuthVC: UIViewController, UITextFieldDelegate {
    
    private var baseView = AuthBaseView()
    private var authView: UIView!
    
    private var authSwitch: Bool = true {
        didSet {
            
            if authSwitch {
                baseView.signUpLabel.text = "Ще не маєте аккаунт?"
                baseView.signUpButton.setTitle("Реєстрація", for: .normal)
            } else {
                baseView.signUpLabel.text = "Маєте акаунт?"
                baseView.signUpButton.setTitle("Вхід", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(baseView)
        baseView.snp.makeConstraints { $0.edges.equalToSuperview() }
        setupAuthView()
        
        baseView.signUpButton.addTarget(self, action: #selector(switchAuthType), for: .touchUpInside)
        
        self.addKeyboardDismissGesture()
    }
}

private extension AuthVC {
    
    @objc func switchAuthType() {
        authSwitch.toggle()
        authView.removeFromSuperview()
        setupAuthView()
    }
    
    func setupAuthView() {
        authView = authSwitch ? SignInView() : SignUpView()
        
        if let authView = authView as? SignInView {
            authView.authButton.addTarget(self, action: #selector(tapAuthButton), for: .touchUpInside)
            authView.forgotPasswordButton.addTarget(self, action: #selector(tapForgotPasswordButton), for: .touchUpInside)
        } else if let authView = authView as? SignUpView {
            authView.authButton.addTarget(self, action: #selector(tapAuthButton), for: .touchUpInside)
        }
        
        view.addSubview(authView)
        authView.snp.makeConstraints {
            $0.top.equalTo(baseView.icon.snp.bottom).inset(-DS.Constraints.authLogoLeadingTrailing)
            $0.leading.trailing.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
    }
    
}

extension AuthVC {
    
    @objc private func tapAuthButton() {
        switch authSwitch {
            
        case true:
            guard let authView_ = authView as? SignInView else { return }
            let email = authView_.userEmailTF.text
            let password = authView_.userPasswordTF.text
            
            guard let email_ = email, let password_ = password else { return }
            print("\(email_) - \(password_)")
            
        case false:
            guard let authView_ = authView as? SignUpView else { return }
            let name = authView_.userNameTF.text
            let email = authView_.userEmailTF.text
            let password = authView_.userPasswordTF.text
            
            guard let name_ = name, let email_ = email, let password_ = password else { return }
            print("\(name_) - \(email_) - \(password_)")
        }
    }
    
    @objc private func tapForgotPasswordButton() {
        print("FORGOT")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
