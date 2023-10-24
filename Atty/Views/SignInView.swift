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
    
    var userEmailTF: UITextField!
    var userPasswordTF: UITextField!
    var authButton: AuthButton!
    var forgotPasswordButton: UIButton!
    
    private var signLabel: UILabel!
    private var authView: UIView!
    private var tfStackView: UIStackView!
    private var emailView: AuthTFView!
    private var passwordView: AuthTFView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraintViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SignInView {
    
    func setupViews() {
        
        backgroundColor = DS.Colors.mainBackgroundColor
        
        signLabel = UILabel()
        signLabel.text = "Вхід"
        signLabel.font = UIFont(name: "Manrope-Bold", size: 50)
        addSubview(signLabel)
        
        tfStackView = UIStackView()
        tfStackView.axis = .vertical
        tfStackView.spacing = CGFloat(DS.Constraints.authTFSpacing)
        addSubview(tfStackView)
        
        emailView = AuthTFView()
        tfStackView.addArrangedSubview(emailView)
        
        userEmailTF = UITextField()
        userEmailTF.backgroundColor = .clear
        userEmailTF.placeholder = "Адреса електронної пошти"
        userEmailTF.autocapitalizationType = .none
        userEmailTF.textContentType = .emailAddress
        userEmailTF.keyboardType = .emailAddress
        emailView.addSubview(userEmailTF)
        
        passwordView = AuthTFView()
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
        addSubview(forgotPasswordButton)
        
        authButton = AuthButton(type: .system)
        authButton.setTitle("Увійти", for: .normal)
        authButton.titleLabel?.font = UIFont(name: "Manrope-ExtraBold", size: 20)
        addSubview(authButton)
    }
    
    func setupConstraintViews() {
        
        
        signLabel.snp.makeConstraints { $0.top.leading.equalToSuperview() }
        
        tfStackView.snp.makeConstraints {
            $0.top.equalTo(signLabel.snp.bottom).inset(-DS.Constraints.authLabelBottomInset)
            $0.leading.trailing.equalToSuperview()
        }
        
        emailView.snp.makeConstraints { $0.height.equalTo(DS.Sizes.authTFHeight) }
        
        userEmailTF.snp.makeConstraints { $0.edges.equalToSuperview().inset(DS.Constraints.authTFInsets)}
        
        passwordView.snp.makeConstraints { $0.height.equalTo(DS.Sizes.authTFHeight) }
        
        userPasswordTF.snp.makeConstraints { $0.edges.equalToSuperview().inset(DS.Constraints.authTFInsets)}
        
        forgotPasswordButton.snp.makeConstraints {
            $0.height.equalTo(DS.Sizes.authTFHeight)
            $0.top.equalTo(tfStackView.snp.bottom)
            $0.trailing.equalToSuperview()
        }
        
        authButton.snp.makeConstraints {
            $0.height.equalTo(DS.Sizes.authTFHeight)
            $0.top.equalTo(forgotPasswordButton.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
