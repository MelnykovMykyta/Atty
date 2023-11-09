//
//  AuthTFView.swift
//  Atty
//
//  Created by Nikita Melnikov on 22.10.2023.
//

import Foundation
import UIKit

class AuthTFView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension AuthTFView {
    
    private func setupView() {
        backgroundColor = DS.Colors.mainBackgroundColor
        layer.borderWidth = 1
        layer.borderColor = DS.Colors.authTFBorder.cgColor
        layer.cornerRadius = 12
        layer.cornerCurve = .continuous
        clipsToBounds = true
    }
}
