//
//  BaseNavBarView.swift
//  Atty
//
//  Created by Nikita Melnikov on 31.10.2023.
//

import Foundation
import UIKit
import SnapKit

class BaseNavBarView: UIView {
    
    var notificationButton: UIButton!
    var userIcon: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraintViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BaseNavBarView {
    
    private func setupViews(){
        
        backgroundColor = DS.Colors.mainBackgroundColor
        
        notificationButton = UIButton(type: .system)
        notificationButton.setImage(UIImage(named: "notificationButton"), for: .normal)
        notificationButton.tintColor = DS.Colors.standartTextColor
        addSubview(notificationButton)
    }
    
    private func setupConstraintViews(){
        
        notificationButton.snp.makeConstraints {
            $0.size.equalTo(DS.Sizes.buttonSize)
            $0.top.trailing.bottom.equalToSuperview().inset(DS.Constraints.navigationBarItem)
        }
    }
    
    func addTitle(with title: String) {
        
        let label = UILabel()
        label.text = title
        label.textColor = DS.Colors.standartTextColor
        label.font = UIFont(name: "Manrope-Bold", size: 32)
        addSubview(label)
        
        label.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(DS.Constraints.navigationBarItem)
        }
    }
    
    func addUser(name: String, status: String, icon: UIImage?) {
        
        userIcon = UIButton(type: .system)
        userIcon.setImage(icon ?? UIImage(named: "defaultUserIcon"), for: .normal)
        userIcon.tintColor = DS.Colors.standartTextColor
        addSubview(userIcon)
        
        let userStatus = UILabel()
        userStatus.text = status
        userStatus.textColor = DS.Colors.standartTextColor
        userStatus.font = UIFont(name: "Manrope-Bold", size: 18)
        
        let userName = UILabel()
        userName.text = name
        userName.textColor = DS.Colors.standartTextColor
        userName.font = UIFont(name: "Manrope-Bold", size: 14)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        addSubview(stackView)
        
        [userStatus, userName].forEach { stackView.addArrangedSubview($0) }
        
        userIcon.snp.makeConstraints {
            $0.size.equalTo(DS.Sizes.buttonSize)
            $0.top.leading.bottom.equalToSuperview().inset(DS.Constraints.navigationBarItem)
        }
        
        stackView.snp.makeConstraints {
            $0.leading.equalTo(userIcon.snp.trailing).inset(-8)
            $0.height.equalTo(userIcon.snp.height).multipliedBy(0.8)
            $0.centerY.equalTo(userIcon.snp.centerY)
        }
    }
}
