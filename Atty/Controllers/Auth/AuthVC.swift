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
    
    private var authView: UIView!
    private var viewModel = AuthViewModel()
    
    private var authSwitch: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAuthView()
        
        self.navigationController?.navigationBar.isHidden = true
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
            authView.signTypeButton.addTarget(self, action: #selector(switchAuthType), for: .touchUpInside)
        } else if let authView = authView as? SignUpView {
            authView.authButton.addTarget(self, action: #selector(tapAuthButton), for: .touchUpInside)
            authView.signTypeButton.addTarget(self, action: #selector(switchAuthType), for: .touchUpInside)
        }
        
        view.addSubview(authView)
        authView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(DS.Constraints.safeAreaInset)
        }
    }
}

extension AuthVC {
    
    @objc private func tapAuthButton() {
        
        switch authSwitch {
        case true:
            viewModel.signInUser(view: authView)
        case false:
            viewModel.signUpUser(view: authView)
        }
    }
    
    @objc private func tapForgotPasswordButton() {
        let vc = ResetPasswordVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


