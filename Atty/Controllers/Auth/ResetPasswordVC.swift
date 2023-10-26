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
        
        resetPasswordView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(DS.Constraints.safeAreaInset)
        }
        resetPasswordView.resetButton.addTarget(self, action: #selector(tapResetPassword), for: .touchUpInside)
        resetPasswordView.closeButton.addTarget(self, action: #selector(tapClose), for: .touchUpInside)
    }
}

extension ResetPasswordVC {
    
    @objc private func tapResetPassword() {
        viewModel.forgotPassword(view: resetPasswordView)
    }
    
    @objc private func tapClose() {
        navigationController?.popViewController(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

