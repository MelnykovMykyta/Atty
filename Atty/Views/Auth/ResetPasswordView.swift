//
//  ResetPasswordView.swift
//  Atty
//
//  Created by Nikita Melnikov on 26.10.2023.
//

import Foundation
import UIKit
import SnapKit

class ResetPasswordView: UIView {
    
    var closeButton: UIButton!
    var userEmailTF: UITextField!
    var resetButton: AuthButton!
    
    private var resetLabel: UILabel!
    private var tfStackView: UIStackView!
    private var emailView: AuthTFView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraintViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ResetPasswordView {
    
    func setupViews() {
        
        backgroundColor = .clear
        
        closeButton = UIButton(type: .system)
        closeButton.setImage(UIImage(named: "closeButton"), for: .normal)
        closeButton.tintColor = DS.Colors.standartTextColor
        addSubview(closeButton)
        
        resetLabel = UILabel()
        resetLabel.text = "Введіть електронну пошту"
        resetLabel.adjustsFontSizeToFitWidth = true
        resetLabel.font = UIFont(name: "Manrope-Bold", size: 50)
        addSubview(resetLabel)
        
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
        
        resetButton = AuthButton(type: .system)
        resetButton.setTitle("Відновити пароль", for: .normal)
        resetButton.titleLabel?.font = UIFont(name: "Manrope-ExtraBold", size: 20)
        tfStackView.addArrangedSubview(resetButton)
    }
    
    func setupConstraintViews() {
        
        closeButton.snp.makeConstraints {
            $0.size.equalTo(DS.Sizes.buttonSize)
            $0.top.trailing.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
        tfStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
        emailView.snp.makeConstraints { $0.height.equalTo(DS.Sizes.authTFHeight) }
        
        userEmailTF.snp.makeConstraints { $0.edges.equalToSuperview().inset(DS.Constraints.authTFInsets) }
        
        resetButton.snp.makeConstraints { $0.height.equalTo(DS.Sizes.authTFHeight) }
        
        resetLabel.snp.makeConstraints {
            $0.bottom.equalTo(tfStackView.snp.top).inset(-DS.Constraints.authLogoLeadingTrailing)
            $0.leading.trailing.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
    }
}



