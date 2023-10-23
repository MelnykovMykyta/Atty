//
//  AuthBaseView.swift
//  Atty
//
//  Created by Nikita Melnikov on 23.10.2023.
//

import Foundation
import UIKit
import SnapKit

class AuthBaseView: UIView {
    
    var icon: UIImageView!
    private var signUpStackView: UIStackView!
    var signUpLabel: UILabel!
    var signUpButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraintViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension AuthBaseView {
    
    func setupViews() {
        
        backgroundColor = DS.Colors.mainBackgroundColor
        
        icon = UIImageView()
        icon.image = UIImage(named: "LaunchScreenLogo")
        addSubview(icon)
        
        signUpStackView = UIStackView()
        signUpStackView.axis = .horizontal
        signUpStackView.spacing = CGFloat(DS.Constraints.authTFSpacing)
        signUpStackView.distribution = .equalCentering
        addSubview(signUpStackView)
        
        signUpLabel = UILabel ()
        signUpLabel.text = "Ще не маєте аккаунт?"
        signUpLabel.textColor = DS.Colors.standartTextColor
        signUpLabel.font = UIFont(name: "Manrope-ExtraLight", size: 14)
        signUpStackView.addArrangedSubview(signUpLabel)
        
        signUpButton = UIButton(type: .system)
        signUpButton.setTitle("Реєстрація", for: .normal)
        signUpButton.setTitleColor(DS.Colors.standartTextColor, for: .normal)
        signUpButton.titleLabel?.font = UIFont(name: "Manrope-SemiBold", size: 14)
        signUpButton.backgroundColor = .clear
        signUpStackView.addArrangedSubview(signUpButton)
    }
    
    func setupConstraintViews() {
        
        icon.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(DS.Constraints.authLogoLeadingTrailing)
            $0.height.equalTo(icon.snp.width).multipliedBy(DS.Sizes.halfSize)
        }
        
        signUpStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(DS.Constraints.safeAreaInset)
        }
    }
}
