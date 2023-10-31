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
        
        navigationBar.addTitle(with: "Проєкти")
    }
}

