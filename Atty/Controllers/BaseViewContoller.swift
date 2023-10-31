//
//  BaseViewContoller.swift
//  Atty
//
//  Created by Nikita Melnikov on 31.10.2023.
//

import Foundation
import UIKit
import SnapKit
import FirebaseAuth

class BaseViewContoller: UIViewController {
    
    var navigationBar: BaseNavBarView!
    var contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraintViews()
    }
}

@objc extension BaseViewContoller {
    
    func setupViews() {
        
        view.backgroundColor = DS.Colors.mainBackgroundColor
        
        navigationBar = BaseNavBarView()
        view.addSubview(navigationBar)
        
        contentView = UIView()
        contentView.backgroundColor = DS.Colors.mainViewColor
        contentView.layer.cornerRadius = 25
        contentView.layer.masksToBounds = true
        view.addSubview(contentView)
    }
    
    func setupConstraintViews() {
        
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
    }
}
