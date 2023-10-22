//
//  DS.swift
//  Atty
//
//  Created by Nikita Melnikov on 22.10.2023.
//

import Foundation
import UIKit

enum DS {
    
    enum Colors {
        static var mainBackgroundColor = UIColor(red: 0.145, green: 0.145, blue: 0.145, alpha: 1)
        static var standartTextColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        static var darkedTextColor = UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1)
        static var authTFBorder = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)
        static var authButtonTextColor = UIColor(red: 0.145, green: 0.145, blue: 0.145, alpha: 1)
        static var authButtonColor = UIColor(red: 0.871, green: 0.871, blue: 0.871, alpha: 1)
    }
    
    enum Constraints {
        static var authLogoLeadingTrailing = 60
        static var authLabelBottomInset = 60
        static var authStackViewLeadinTrailing = 16
        static var authTFInsets = 20
        static var safeAreaInset = 12

    }
    
    enum Sizes {
        static var halfSize = 0.5
        static var authTFHeight = 60


    }
}
