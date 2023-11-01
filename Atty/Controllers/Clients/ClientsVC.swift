//
//  ClientsVC.swift
//  Atty
//
//  Created by Nikita Melnikov on 26.10.2023.
//

import Foundation
import UIKit
import SnapKit
import FirebaseAuth

class ClientsVC: BaseViewContoller {
    
    private var nextbtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
    }
}

private extension ClientsVC {
    
    func addViews() {
        
        navigationBar.addTitle(with: Tabs.clients.itemTitle)
        infoView.setInfo(title: "Кількість", value: 4)
        infoView.setAddView(title: "Додати клієнта")
        infoView.addInfoButton()
        infoView.infoButton.addTarget(self, action: #selector(addClient), for: .touchUpInside)
    }
    
    @objc func addClient() {
        print("addClient")
    }
}
