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

class MainVC: UIViewController, UITextFieldDelegate {
    
    private var label: UILabel!
    private var logout: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBaseView()
    }
}

private extension MainVC {
    
    func setupBaseView() {
        
        view.backgroundColor = DS.Colors.mainBackgroundColor
        
        label = UILabel()
        label.text = "MAIN"
        label.font = UIFont(name: "Manrope-Bold", size: 50)
        label.textAlignment = .center
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(200)
        }
        
        logout = UIButton(type: .system)
        logout.setTitle("Вихід", for: .normal)
        logout.addTarget(self, action: #selector(logouttap), for: .touchUpInside)
        view.addSubview(logout)
        logout.snp.makeConstraints { $0.center.equalToSuperview() }
    }
    
    @objc func logouttap() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkAuthentication()
            }
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        
        if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
            sceneDelegate.checkAuthentication()
        }
    }
}