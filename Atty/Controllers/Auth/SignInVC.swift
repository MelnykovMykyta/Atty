//
//  SignInVC.swift
//  Atty
//
//  Created by Nikita Melnikov on 12.11.2023.
//

import Foundation
import UIKit
import SnapKit

class SignInVC: UIViewController, UITextFieldDelegate {
    
    var signUpButton: UIButton!
    var userEmailTF: UITextField!
    var userPasswordTF: UITextField!
    var authButton: AuthButton!
    var forgotPasswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        self.navigationController?.navigationBar.isHidden = true
        self.addKeyboardDismissGesture()
        
        authButton.addTarget(self, action: #selector(tapSignIn), for: .touchUpInside)
        forgotPasswordButton.addTarget(self, action: #selector(tapForgotPassword), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(tapSignUp), for: .touchUpInside)
    }
}

private extension SignInVC {
    
    func setupViews() {
        
        view.backgroundColor = .clear
        
        let icon = UIImageView()
        icon.image = UIImage(named: "LaunchScreenLogo")
        view.addSubview(icon)
        
        let signLabel = UILabel()
        signLabel.text = "Вхід"
        signLabel.font = UIFont(name: "Manrope-Bold", size: 50)
        view.addSubview(signLabel)
        
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
        
        let passwordView = AuthTFView()
        tfStackView.addArrangedSubview(passwordView)
        
        userPasswordTF = UITextField()
        userPasswordTF.backgroundColor = .clear
        userPasswordTF.placeholder = "Пароль"
        userPasswordTF.autocapitalizationType = .none
        userPasswordTF.textContentType = .password
        userPasswordTF.isSecureTextEntry = true
        passwordView.addSubview(userPasswordTF)
        
        forgotPasswordButton = UIButton(type: .system)
        forgotPasswordButton.setTitle("Забули пароль?", for: .normal)
        forgotPasswordButton.setTitleColor(DS.Colors.standartTextColor, for: .normal)
        forgotPasswordButton.titleLabel?.font = UIFont(name: "Manrope-SemiBold", size: 14)
        forgotPasswordButton.backgroundColor = .clear
        view.addSubview(forgotPasswordButton)
        
        authButton = AuthButton(type: .system)
        authButton.setTitle("Увійти", for: .normal)
        authButton.titleLabel?.font = UIFont(name: "Manrope-ExtraBold", size: 20)
        view.addSubview(authButton)
        
        let signUpSV = UIStackView()
        signUpSV.axis = .horizontal
        signUpSV.spacing = CGFloat(DS.Constraints.authTFSpacing)
        signUpSV.distribution = .equalCentering
        view.addSubview(signUpSV)
        
        let signUpLabel = UILabel ()
        signUpLabel.text = "Ще не маєте аккаунт?"
        signUpLabel.textAlignment = .right
        signUpLabel.textColor = DS.Colors.standartTextColor
        signUpLabel.font = UIFont(name: "Manrope-ExtraLight", size: 14)
        signUpSV.addArrangedSubview(signUpLabel)
        
        signUpButton = UIButton(type: .system)
        signUpButton.setTitle("Реєстрація", for: .normal)
        signUpButton.setTitleColor(DS.Colors.standartTextColor, for: .normal)
        signUpButton.titleLabel?.font = UIFont(name: "Manrope-SemiBold", size: 14)
        signUpButton.backgroundColor = .clear
        signUpSV.addArrangedSubview(signUpButton)
        
        icon.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview().inset(DS.Constraints.authLogoLeadingTrailing)
            $0.height.equalTo(icon.snp.width).multipliedBy(DS.SizeMultipliers.halfSize)
        }
        
        signLabel.snp.makeConstraints {
            $0.top.equalTo(icon.snp.bottom).inset(-DS.Constraints.authLogoLeadingTrailing)
            $0.leading.trailing.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
        tfStackView.snp.makeConstraints {
            $0.top.equalTo(signLabel.snp.bottom).inset(-DS.Constraints.authLabelBottomInset)
            $0.leading.trailing.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
        emailView.snp.makeConstraints {
            $0.height.equalTo(DS.Sizes.authTFHeight)
        }
        
        userEmailTF.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(DS.Constraints.authTFInsets)
        }
        
        passwordView.snp.makeConstraints {
            $0.height.equalTo(DS.Sizes.authTFHeight)
        }
        
        userPasswordTF.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(DS.Constraints.authTFInsets)
        }
        
        forgotPasswordButton.snp.makeConstraints {
            $0.height.equalTo(DS.Sizes.authTFHeight)
            $0.top.equalTo(tfStackView.snp.bottom)
            $0.trailing.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
        authButton.snp.makeConstraints {
            $0.height.equalTo(DS.Sizes.authTFHeight)
            $0.top.equalTo(forgotPasswordButton.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
        signUpSV.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(DS.Constraints.safeAreaInset)
        }
    }
}

extension SignInVC {
    
    @objc private func tapSignIn() {
        guard let email = userEmailTF.text, let password = userPasswordTF.text else { return }
        AuthViewModel.signInUser(email: email, password: password)
    }
    
    @objc private func tapForgotPassword() {
        FirebaseAuthService.shared.changeVCAuth(vc: ResetPasswordVC())
    }
    
    @objc private func tapSignUp() {
        FirebaseAuthService.shared.changeVCAuth(vc: SignUpVC())
    }
}
