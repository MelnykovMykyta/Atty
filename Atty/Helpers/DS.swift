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
        static var tabBarColor = UIColor(red: 0.145, green: 0.145, blue: 0.145, alpha: 1)
        static var tabBarUnselectTabColor = UIColor(red: 0.145, green: 0.145, blue: 0.145, alpha: 1)
        static var standartTextColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        static var darkedTextColor = UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1)
        static var authTFBorder = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)
        static var authButtonTextColor = UIColor(red: 0.145, green: 0.145, blue: 0.145, alpha: 1)
        static var authButtonColor = UIColor(red: 0.871, green: 0.871, blue: 0.871, alpha: 1)
        static var mainViewColor = UIColor(red: 0.102, green: 0.102, blue: 0.102, alpha: 1)
    }
    
    enum Constraints {
        static var authLogoLeadingTrailing = 60
        static var authLabelBottomInset = 20
        static var authViewLeadinTrailing = 16
        static var authTFInsets = 20
        static var authTFSpacing = 8
        static var safeAreaInset = 12
        static var navigationBarItem = 20
    }
    
    enum Sizes {
        static var halfSize = 0.5
        static var authTFHeight = 60
        static var buttonSize = 50
    }
    
    enum AlertMessages {
        static var attention = "Увага!"
        static var emptyLine = "Заповніть всі поля!"
        static var wrongEmail = "Введіть коректну адресу електронної пошти!"
        static var wrongPassword = "Пароль повинен містити як мінімум 6 символів (літери верхнього та нижнього регістру, цифри, символи _ . % + -"
        static var forgotPassword = "На Вашу електронну пошту надіслано посилання для відновлення паролю"
    }
}
