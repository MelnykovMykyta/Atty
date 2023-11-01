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
    
    private var label: UILabel!
    private var logout: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        setupConstraints()
    }
}

private extension MainVC {
    
    func addViews() {
        
        navigationBar.addUser(name: "Микита Мельников", status: "Адвокат", icon: nil)
        infoView.setMainTodayInfo(date: "31 жовтня 2023", todayTasksValue: 2, todayCourtMeets: 2)
        infoView.setCostsView()
        infoView.addInfoButton()
        infoView.infoButton.addTarget(self, action: #selector(tapCostsInfo), for: .touchUpInside)
        
        logout = UIButton(type: .system)
        logout.setTitle("Вихід", for: .normal)
        logout.addTarget(self, action: #selector(logouttap), for: .touchUpInside)
        contentView.addSubview(logout)
    }
    
    func setupConstraints() {
        
        logout.snp.makeConstraints { $0.center.equalToSuperview() }
    }
    
    @objc func logouttap() {
        FirebaseAuthService.shared.logout()
    }
    
    @objc func tapCostsInfo() {
        print("Soon")
    }
}
