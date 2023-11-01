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

class ProjectsVC: BaseViewContoller {
    
    private var nextbtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
    }
}

private extension ProjectsVC {
    
    func addViews() {
        
        navigationBar.addTitle(with: Tabs.projects.itemTitle)
        infoView.setInfoWithValueFrom(title: "Завершені", value: 2, from: 4)
        infoView.setAddView(title: "Додати проєкт")
        infoView.addInfoButton()
        infoView.infoButton.addTarget(self, action: #selector(addProject), for: .touchUpInside)
    }
    
    @objc func addProject() {
        print("addProject")
    }
}

