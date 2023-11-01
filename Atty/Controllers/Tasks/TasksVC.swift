//
//  TasksVC.swift
//  Atty
//
//  Created by Nikita Melnikov on 26.10.2023.
//

import Foundation
import UIKit
import SnapKit
import FirebaseAuth

class TasksVC: BaseViewContoller {
    
    private var nextbtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
    }
}

private extension TasksVC {
    
    func addViews() {
        
        navigationBar.addTitle(with: Tabs.tasks.itemTitle)
        infoView.setInfoWithValueFrom(title: "Завершені", value: 3, from: 8)
        infoView.setAddView(title: "Додати задачу")
        infoView.addInfoButton()
        infoView.infoButton.addTarget(self, action: #selector(addNewTask), for: .touchUpInside)
    }
    
    @objc func addNewTask() {
        print("addNewTask")
    }
}
