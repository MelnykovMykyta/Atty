//
//  MainVC.swift
//  Atty
//
//  Created by Nikita Melnikov on 24.10.2023.
//

import Foundation
import UIKit
import SnapKit
import FirebaseAuth

class MainVC: BaseViewContoller, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
    }
}

private extension MainVC {
    
    func addViews() {
        
        navigationBar.addUser(name: "Микита Мельников", status: "Адвокат", icon: nil)
        navigationBar.userIcon.addTarget(self, action: #selector(logouttap), for: .touchUpInside)
        infoView.setMainTodayInfo(date: "31 жовтня 2023", todayTasksValue: 2, todayCourtMeets: 2)
        infoView.setCostsView()
        infoView.addInfoButton()
        infoView.infoButton.addTarget(self, action: #selector(tapCostsInfo), for: .touchUpInside)
        addtable(with: MainTV())
    }
    
    @objc func logouttap() {
        FirebaseAuthService.shared.logout()
    }
    
    @objc func tapCostsInfo() {
        print("Soon")
    }
    
}
