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
        static var mainInfoView = UIColor(red: 0.235, green: 0.282, blue: 0.965, alpha: 1)
        static var additionallyInfoView = UIColor(red: 0.133, green: 0.133, blue: 0.133, alpha: 1)
        static var lightGray = UIColor(red: 0.176, green: 0.173, blue: 0.173, alpha: 1)
        static var taskStarted = UIColor(red: 0.176, green: 0.173, blue: 0.173, alpha: 1)
        static var taskFinished = UIColor(red: 0.6, green: 0.808, blue: 0.4, alpha: 1)
        static var selectedSegmentControllerItem = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 0.5)
    }
    
    enum Constraints {
        static var authLogoLeadingTrailing = 60
        static var authLabelBottomInset = 20
        static var authViewLeadinTrailing = 16
        static var authTFInsets = 20
        static var authTFSpacing = 8
        static var safeAreaInset = 12
        static var navigationBarItem = 20
        static var baseInsetViews = 8
        static var infoViewLabelInset = 4
    }
    
    enum Sizes {
        static var authTFHeight = 60
        static var buttonSize = 40
        static var backButtonSize = 20
    }
    
    enum SizeMultipliers {
        static var halfSize = 0.5
        static var mainInfoViewWidth = 0.55
        static var mainInfoViewHeidht = 0.6
        static var tenPercent = 0.1
        static var fifteenPercent = 0.15
        static var twentyPercent = 0.2
        static var quarterSize = 0.25
        static var fortyPercent = 0.4
        static var seventyPercent = 0.7
        static var eightyPercent = 0.8
        
    }
    
    enum AlertMessages {
        static var attention = "Увага!"
        static var emptyLine = "Заповніть всі поля!"
        static var wrongEmail = "Введіть коректну адресу електронної пошти!"
        static var wrongPassword = "Пароль повинен містити як мінімум 6 символів (літери верхнього та нижнього регістру, цифри, символи _ . % + -"
        static var forgotPassword = "На Вашу електронну пошту надіслано посилання для відновлення паролю"
    }
    
    enum CornerRadius {
        static var baseCornerRadiusLayers = 20.0
    }
    
}
