//
//  ProjectsVC.swift
//  Atty
//
//  Created by Nikita Melnikov on 26.10.2023.
//

import Foundation
import UIKit
import SnapKit
import FirebaseAuth

class ProjectsVC: UIViewController, UITextFieldDelegate {
    
    private var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBaseView()
    }
}

private extension ProjectsVC {
    
    func setupBaseView() {
        
        view.backgroundColor = DS.Colors.mainBackgroundColor
        
        label = UILabel()
        label.text = "ProjectsVC"
        label.font = UIFont(name: "Manrope-Bold", size: 50)
        label.textAlignment = .center
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(200)
        }
        
       
    }
}

