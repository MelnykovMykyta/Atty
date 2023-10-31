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
}
