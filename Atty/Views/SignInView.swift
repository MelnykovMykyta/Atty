//
//  SignInView.swift
//  Atty
//
//  Created by Nikita Melnikov on 22.10.2023.
//

import Foundation
import UIKit
import SnapKit

class SignInView: UIView {
    
    private var icon: UIImageView!
    private var signLabel: UILabel!
    private var tfStackView: UIStackView!
    private var emailView: AuthTFView!
    private var passwordView: AuthTFView!
    private var userEmailTF: UITextField!
    private var userPasswordTF: UITextField!
    private var signInButton: AuthButton!
    private var signUpStackView: UIStackView!
    private var signUpLabel: UILabel!
    private var signUpButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraintViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension SignInView {
    
    func setupViews() {
        backgroundColor = DS.Colors.mainBackgroundColor
        
        icon = UIImageView()
        icon.image = UIImage(named: "LaunchScreenLogo")
        addSubview(icon)
        
        signLabel = UILabel()
        signLabel.text = "Вхід"
        signLabel.font = UIFont(name: "Helvetica", size: 28)
        addSubview(signLabel)
        
        tfStackView = UIStackView()
        tfStackView.axis = .vertical
        tfStackView.spacing = 8
        tfStackView.distribution = .fillEqually
        addSubview(tfStackView)
        
        emailView = AuthTFView()
        tfStackView.addArrangedSubview(emailView)
        
        userEmailTF = UITextField()
        userEmailTF.backgroundColor = .clear
        userEmailTF.placeholder = "Адреса електронної пошти"
        userEmailTF.textContentType = .emailAddress
        userEmailTF.keyboardType = .emailAddress
        emailView.addSubview(userEmailTF)
        
        passwordView = AuthTFView()
        tfStackView.addArrangedSubview(passwordView)
        
        userPasswordTF = UITextField()
        userPasswordTF.backgroundColor = .clear
        userPasswordTF.placeholder = "Пароль"
        userPasswordTF.textContentType = .password
        userPasswordTF.isSecureTextEntry = true
        passwordView.addSubview(userPasswordTF)
        
        signInButton = AuthButton(type: .system)
        signInButton.setTitle("Увійти", for: .normal)
        tfStackView.addArrangedSubview(signInButton)
        
      signUpStackView = UIStackView()
        signUpStackView.axis = .horizontal
        signUpStackView.spacing = 8
        signUpStackView.distribution = .fillProportionally
        addSubview(signUpStackView)
        
    signUpLabel = UILabel ()
        signUpLabel.text = "Ще не маєте аккаунт?"
        signUpLabel.textColor = DS.Colors.standartTextColor
        signUpStackView.addArrangedSubview(signUpLabel)
        
        signUpButton = UIButton(type: .system)
        signUpButton.setTitle("Реєстрація", for: .normal)
        signUpButton.setTitleColor(DS.Colors.standartTextColor, for: .normal)
        signUpButton.backgroundColor = .clear
        signUpStackView.addArrangedSubview(signUpButton)
    }
    
    func setupConstraintViews() {
        
        icon.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).inset(DS.Constraints.safeAreaInset)
            $0.leading.trailing.equalToSuperview().inset(DS.Constraints.authLogoLeadingTrailing)
            $0.height.equalTo(icon.snp.width).multipliedBy(DS.Sizes.halfSize)
        }
        signLabel.snp.makeConstraints {
            $0.bottom.equalTo(tfStackView.snp.top).inset(-DS.Constraints.authLabelBottomInset)
            $0.leading.equalToSuperview().inset(DS.Constraints.authStackViewLeadinTrailing)
        }
        tfStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(DS.Constraints.authStackViewLeadinTrailing)
        }
        
        emailView.snp.makeConstraints { $0.height.equalTo(DS.Sizes.authTFHeight) }
        
        userEmailTF.snp.makeConstraints { $0.edges.equalToSuperview().inset(DS.Constraints.authTFInsets)}
        
        passwordView.snp.makeConstraints { $0.height.equalTo(DS.Sizes.authTFHeight) }
        
        userPasswordTF.snp.makeConstraints { $0.edges.equalToSuperview().inset(DS.Constraints.authTFInsets)}
        
        signInButton.snp.makeConstraints { $0.height.equalTo(DS.Sizes.authTFHeight)}
        
        signUpStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(DS.Constraints.safeAreaInset)
        }
    }
}
