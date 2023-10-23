//
//  SignUpView.swift
//  Atty
//
//  Created by Nikita Melnikov on 22.10.2023.
//

import Foundation
import UIKit
import SnapKit

class SignUpView: UIView {
    
    var userNameTF: UITextField!
    var userEmailTF: UITextField!
    var userPasswordTF: UITextField!
    var authButton: AuthButton!
    var signInButton: UIButton!
    
    private var signLabel: UILabel!
    private var tfStackView: UIStackView!
    private var nameView: AuthTFView!
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

extension SignUpView {
    
    func setupViews() {
        backgroundColor = DS.Colors.mainBackgroundColor
        
        signLabel = UILabel()
        signLabel.text = "Реєстрація"
        signLabel.font = UIFont(name: "Manrope-Bold", size: 50)
        addSubview(signLabel)
        
        tfStackView = UIStackView()
        tfStackView.axis = .vertical
        tfStackView.spacing = 12
        addSubview(tfStackView)
        
        nameView = AuthTFView()
        tfStackView.addArrangedSubview(nameView)
        
        userNameTF = UITextField()
        userNameTF.backgroundColor = .clear
        userNameTF.placeholder = "Введіть ім'я"
        userNameTF.textContentType = .emailAddress
        userNameTF.keyboardType = .emailAddress
        nameView.addSubview(userNameTF)
        
        emailView = AuthTFView()
        tfStackView.addArrangedSubview(emailView)
        
        userEmailTF = UITextField()
        userEmailTF.backgroundColor = .clear
        userEmailTF.placeholder = "Введіть електронну пошту"
        userEmailTF.textContentType = .emailAddress
        userEmailTF.keyboardType = .emailAddress
        emailView.addSubview(userEmailTF)
        
        passwordView = AuthTFView()
        tfStackView.addArrangedSubview(passwordView)
        
        userPasswordTF = UITextField()
        userPasswordTF.backgroundColor = .clear
        userPasswordTF.placeholder = "Введіть пароль"
        userPasswordTF.textContentType = .password
        userPasswordTF.isSecureTextEntry = true
        passwordView.addSubview(userPasswordTF)
        
        authButton = AuthButton(type: .system)
        authButton.setTitle("Зареєструвати", for: .normal)
        authButton.titleLabel?.font = UIFont(name: "Manrope-ExtraBold", size: 18)
        tfStackView.addArrangedSubview(authButton)
    }
    
    func setupConstraintViews() {
        
        signLabel.snp.makeConstraints { $0.top.leading.equalToSuperview() }
        
        tfStackView.snp.makeConstraints {
            $0.top.equalTo(signLabel.snp.bottom).inset(-DS.Constraints.authLabelBottomInset)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        nameView.snp.makeConstraints { $0.height.equalTo(DS.Sizes.authTFHeight) }
        
        userNameTF.snp.makeConstraints { $0.edges.equalToSuperview().inset(DS.Constraints.authTFInsets) }
        
        emailView.snp.makeConstraints { $0.height.equalTo(DS.Sizes.authTFHeight) }
        
        userEmailTF.snp.makeConstraints { $0.edges.equalToSuperview().inset(DS.Constraints.authTFInsets) }
        
        passwordView.snp.makeConstraints { $0.height.equalTo(DS.Sizes.authTFHeight) }
        
        userPasswordTF.snp.makeConstraints { $0.edges.equalToSuperview().inset(DS.Constraints.authTFInsets) }
        
        authButton.snp.makeConstraints { $0.height.equalTo(DS.Sizes.authTFHeight) }
    }
}
