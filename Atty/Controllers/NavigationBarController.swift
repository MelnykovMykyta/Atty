//
//  NavigationBarController.swift
//  Atty
//
//  Created by Nikita Melnikov on 30.10.2023.
//

import Foundation
import UIKit

class NavigationBarController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
}

private extension NavigationBarController {
    
    func setupView() {
        view.backgroundColor = DS.Colors.mainBackgroundColor
        navigationBar.isHidden = true
    }
}
