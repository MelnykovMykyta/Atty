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
    
    var closeButton: UIButton!
    var userEmailTF: UITextField!
    var resetButton: AuthButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        self.addKeyboardDismissGesture()
        
        resetButton.addTarget(self, action: #selector(tapResetPassword), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(tapClose), for: .touchUpInside)
    }
}

private extension ResetPasswordVC {
    
    func setupViews() {
        
        view.backgroundColor = .clear
        
        closeButton = UIButton(type: .system)
        closeButton.setImage(UIImage(named: "closeButton"), for: .normal)
        closeButton.tintColor = DS.Colors.standartTextColor
        view.addSubview(closeButton)
        
        let resetLabel = UILabel()
        resetLabel.text = "Введіть електронну пошту"
        resetLabel.adjustsFontSizeToFitWidth = true
        resetLabel.font = UIFont(name: "Manrope-Bold", size: 50)
        view.addSubview(resetLabel)
        
        let tfStackView = UIStackView()
        tfStackView.axis = .vertical
        tfStackView.spacing = CGFloat(DS.Constraints.authTFSpacing)
        view.addSubview(tfStackView)
        
        let emailView = AuthTFView()
        tfStackView.addArrangedSubview(emailView)
        
        userEmailTF = UITextField()
        userEmailTF.backgroundColor = .clear
        userEmailTF.placeholder = "Адреса електронної пошти"
        userEmailTF.autocapitalizationType = .none
        userEmailTF.textContentType = .emailAddress
        userEmailTF.keyboardType = .emailAddress
        emailView.addSubview(userEmailTF)
        
        resetButton = AuthButton(type: .system)
        resetButton.setTitle("Відновити пароль", for: .normal)
        resetButton.titleLabel?.font = UIFont(name: "Manrope-ExtraBold", size: 20)
        tfStackView.addArrangedSubview(resetButton)
        
        closeButton.snp.makeConstraints {
            $0.size.equalTo(DS.Sizes.buttonSize)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.trailing.equalToSuperview().inset(DS.Constraints.navigationBarItem)
        }
        
        tfStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
        emailView.snp.makeConstraints {
            $0.height.equalTo(DS.Sizes.authTFHeight)
        }
        
        userEmailTF.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(DS.Constraints.authTFInsets)
        }
        
        resetButton.snp.makeConstraints {
            $0.height.equalTo(DS.Sizes.authTFHeight)
        }
        
        resetLabel.snp.makeConstraints {
            $0.bottom.equalTo(tfStackView.snp.top).inset(-DS.Constraints.authLogoLeadingTrailing)
            $0.leading.trailing.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
    }
}

extension ResetPasswordVC {
    
    @objc private func tapResetPassword() {
        guard let email = userEmailTF.text else { return }
        AuthViewModel.forgotPassword(email: email)
    }
    
    @objc private func tapClose() {
        FirebaseAuthService.shared.changeVCAuth(vc: SignInVC())
    }
}

