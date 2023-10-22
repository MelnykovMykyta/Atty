//
//  AuthButton.swift
//  Atty
//
//  Created by Nikita Melnikov on 22.10.2023.
//

import Foundation
import UIKit

class AuthButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AuthButton {
    private func setupView() {
        layer.cornerRadius = 12
        clipsToBounds = true
        setTitleColor(DS.Colors.authButtonTextColor, for: .normal)
        backgroundColor = DS.Colors.authButtonColor
    }
}
