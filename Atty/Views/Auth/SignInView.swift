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
    
    var signTypeButton: UIButton!
    var userEmailTF: UITextField!
    var userPasswordTF: UITextField!
    var authButton: AuthButton!
    var forgotPasswordButton: UIButton!
    
    private var icon: UIImageView!
    private var signTypeStackView: UIStackView!
    private var signTypeLabel: UILabel!
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
        
        backgroundColor = .clear
        
        icon = UIImageView()
        icon.image = UIImage(named: "LaunchScreenLogo")
        addSubview(icon)
        
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
        
        signTypeStackView = UIStackView()
        signTypeStackView.axis = .horizontal
        signTypeStackView.spacing = CGFloat(DS.Constraints.authTFSpacing)
        signTypeStackView.distribution = .equalCentering
        addSubview(signTypeStackView)
        
        signTypeLabel = UILabel ()
        signTypeLabel.text = "Ще не маєте аккаунт?"
        signTypeLabel.textAlignment = .right
        signTypeLabel.textColor = DS.Colors.standartTextColor
        signTypeLabel.font = UIFont(name: "Manrope-ExtraLight", size: 14)
        signTypeStackView.addArrangedSubview(signTypeLabel)
        
        signTypeButton = UIButton(type: .system)
        signTypeButton.setTitle("Реєстрація", for: .normal)
        signTypeButton.setTitleColor(DS.Colors.standartTextColor, for: .normal)
        signTypeButton.titleLabel?.font = UIFont(name: "Manrope-SemiBold", size: 14)
        signTypeButton.backgroundColor = .clear
        signTypeStackView.addArrangedSubview(signTypeButton)
    }
    
    func setupConstraintViews() {
        
        icon.snp.makeConstraints {
            $0.top.equalToSuperview()
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
        
        emailView.snp.makeConstraints { $0.height.equalTo(DS.Sizes.authTFHeight) }
        
        userEmailTF.snp.makeConstraints { $0.edges.equalToSuperview().inset(DS.Constraints.authTFInsets) }
        
        passwordView.snp.makeConstraints { $0.height.equalTo(DS.Sizes.authTFHeight) }
        
        userPasswordTF.snp.makeConstraints { $0.edges.equalToSuperview().inset(DS.Constraints.authTFInsets) }
        
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
        
        signTypeStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(DS.Constraints.safeAreaInset)
        }
    }
}
