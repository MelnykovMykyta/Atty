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
    private var signTypeStackView: UIStackView!
    var signTypeLabel: UILabel!
    var signTypeButton: UIButton!
    
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
        signTypeButton.semanticContentAttribute = .forceRightToLeft
        signTypeButton.setTitleColor(DS.Colors.standartTextColor, for: .normal)
        signTypeButton.titleLabel?.font = UIFont(name: "Manrope-SemiBold", size: 14)
        signTypeButton.backgroundColor = .clear
        signTypeStackView.addArrangedSubview(signTypeButton)
    }
    
    func setupConstraintViews() {
        
        icon.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(DS.Constraints.authLogoLeadingTrailing)
            $0.height.equalTo(icon.snp.width).multipliedBy(DS.Sizes.halfSize)
        }
        
        signTypeStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(DS.Constraints.safeAreaInset)
        }
    }
}
