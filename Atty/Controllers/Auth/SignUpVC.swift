//
//  SignUpVC.swift
//  Atty
//
//  Created by Nikita Melnikov on 12.11.2023.
//

import Foundation
import UIKit
import SnapKit

class SignUpVC: UIViewController, UITextFieldDelegate {
    
    var signInButton: UIButton!
    var userNameTF: UITextField!
    var userStatus: UITextField!
    var userEmailTF: UITextField!
    var userPasswordTF: UITextField!
    var signUpButton: AuthButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        self.navigationController?.navigationBar.isHidden = true
        self.addKeyboardDismissGesture()
        
        signUpButton.addTarget(self, action: #selector(tapSignUn), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(tapSignIn), for: .touchUpInside)
    }
}

private extension SignUpVC {
    
    func setupViews() {
        
        view.backgroundColor = .clear
        
        let icon = UIImageView()
        icon.image = UIImage(named: "LaunchScreenLogo")
        view.addSubview(icon)
        
        let signLabel = UILabel()
        signLabel.text = "Реєстрація"
        signLabel.font = UIFont(name: "Manrope-Bold", size: 50)
        view.addSubview(signLabel)
        
        let tfStackView = UIStackView()
        tfStackView.axis = .vertical
        tfStackView.spacing = CGFloat(DS.Constraints.authTFSpacing)
        view.addSubview(tfStackView)
        
        let nameView = AuthTFView()
        tfStackView.addArrangedSubview(nameView)
        
        userNameTF = UITextField()
        userNameTF.backgroundColor = .clear
        userNameTF.placeholder = "Введіть ім'я"
        userNameTF.autocapitalizationType = .none
        userNameTF.textContentType = .name
        nameView.addSubview(userNameTF)
        
        let userStatusView = AuthTFView()
        tfStackView.addArrangedSubview(userStatusView)
        
        userStatus = UITextField()
        userStatus.backgroundColor = .clear
        userStatus.placeholder = "Посада/статус"
        userStatus.autocapitalizationType = .none
        userStatusView.addSubview(userStatus)
        
        let emailView = AuthTFView()
        tfStackView.addArrangedSubview(emailView)
        
        userEmailTF = UITextField()
        userEmailTF.backgroundColor = .clear
        userEmailTF.placeholder = "Введіть електронну пошту"
        userEmailTF.autocapitalizationType = .none
        userEmailTF.textContentType = .emailAddress
        userEmailTF.keyboardType = .emailAddress
        emailView.addSubview(userEmailTF)
        
        let passwordView = AuthTFView()
        tfStackView.addArrangedSubview(passwordView)
        
        userPasswordTF = UITextField()
        userPasswordTF.backgroundColor = .clear
        userPasswordTF.placeholder = "Введіть пароль"
        userPasswordTF.autocapitalizationType = .none
        userPasswordTF.textContentType = .password
        userPasswordTF.isSecureTextEntry = true
        passwordView.addSubview(userPasswordTF)
        
        signUpButton = AuthButton(type: .system)
        signUpButton.setTitle("Зареєструвати", for: .normal)
        signUpButton.titleLabel?.font = UIFont(name: "Manrope-ExtraBold", size: 18)
        tfStackView.addArrangedSubview(signUpButton)
        
        let signInSV = UIStackView()
        signInSV.axis = .horizontal
        signInSV.spacing = CGFloat(DS.Constraints.authTFSpacing)
        signInSV.distribution = .equalCentering
        view.addSubview(signInSV)
        
        let signInLabel = UILabel ()
        signInLabel.text = "Вже маєте акаунт?"
        signInLabel.textAlignment = .right
        signInLabel.textColor = DS.Colors.standartTextColor
        signInLabel.font = UIFont(name: "Manrope-ExtraLight", size: 14)
        signInSV.addArrangedSubview(signInLabel)
        
        signInButton = UIButton(type: .system)
        signInButton.setTitle("Вхід", for: .normal)
        signInButton.setTitleColor(DS.Colors.standartTextColor, for: .normal)
        signInButton.titleLabel?.font = UIFont(name: "Manrope-SemiBold", size: 14)
        signInButton.backgroundColor = .clear
        signInSV.addArrangedSubview(signInButton)
        
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
        
        nameView.snp.makeConstraints {
            $0.height.equalTo(DS.Sizes.authTFHeight)
        }
        
        userNameTF.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(DS.Constraints.authTFInsets)
        }
        
        userStatusView.snp.makeConstraints {
            $0.height.equalTo(DS.Sizes.authTFHeight)
        }
        
        userStatus.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(DS.Constraints.authTFInsets)
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
        
        signUpButton.snp.makeConstraints {
            $0.height.equalTo(DS.Sizes.authTFHeight)
        }
        
        signInSV.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(DS.Constraints.safeAreaInset)
        }
    }
}

extension SignUpVC {
    
    @objc private func tapSignUn() {
        guard let name = userNameTF.text,
              let userStatus = userStatus.text,
              let email = userEmailTF.text,
              let password = userPasswordTF.text
        else { return }
        
        AuthViewModel.signUpUser(name: name, userStatus: userStatus, email: email, password: password)
    }
    
    @objc private func tapSignIn() {
        FirebaseAuthService.shared.changeVCAuth(vc: SignInVC())
    }
}

