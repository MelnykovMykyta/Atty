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
    
    private var resetLabel: UILabel!
    private var tfStackView: UIStackView!
    private var emailView: AuthTFView!
    var userEmailTF: UITextField!
    var resetButton: AuthButton!
    
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
        
        backgroundColor = DS.Colors.mainBackgroundColor
        
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
        
        resetLabel.snp.makeConstraints {$0.top.leading.trailing.equalToSuperview() }
        
        tfStackView.snp.makeConstraints {
            $0.top.equalTo(resetLabel.snp.bottom).inset(-DS.Constraints.authLabelBottomInset)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        emailView.snp.makeConstraints { $0.height.equalTo(DS.Sizes.authTFHeight) }
        
        userEmailTF.snp.makeConstraints { $0.edges.equalToSuperview().inset(DS.Constraints.authTFInsets) }
        
        resetButton.snp.makeConstraints { $0.height.equalTo(DS.Sizes.authTFHeight) }
    }
}



