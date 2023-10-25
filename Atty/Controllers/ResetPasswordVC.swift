//
//  ResetPasswordVC.swift
//  Atty
//
//  Created by Nikita Melnikov on 25.10.2023.
//

import Foundation
import UIKit
import SnapKit

class ResetPasswordVC: UIViewController, UITextFieldDelegate {
    
    private var viewModel = AuthViewModel()
    private var resetPasswordView = ResetPasswordView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        self.addKeyboardDismissGesture()
    }
}

private extension ResetPasswordVC {
    
    func setupViews() {
        
        view.backgroundColor = DS.Colors.mainBackgroundColor
        
        view.addSubview(resetPasswordView)
        
        resetPasswordView.resetButton.addTarget(self, action: #selector(tapResetPassword), for: .touchUpInside)
        
        resetPasswordView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
    }
}

extension ResetPasswordVC {
    
    @objc func tapResetPassword() {
        viewModel.forgotPassword(view: resetPasswordView)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

