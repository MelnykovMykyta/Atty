//
//  HeaderTVC.swift
//  Atty
//
//  Created by Nikita Melnikov on 02.11.2023.
//

import Foundation
import UIKit
import SnapKit

class HeaderTVC: UITableViewCell {
    
    var label: UILabel!
    var button: UIButton!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HeaderTVC {
    
    func addViews(title: String, buttonTitle: String) {
        
        label = UILabel()
        label.text = title
        label.textColor = DS.Colors.standartTextColor
        label.font = UIFont(name: "Manrope-Bold", size: 100)
        label.adjustsFontSizeToFitWidth = true
        contentView.addSubview(label)
        
        button = UIButton(type: .system)
        button.setTitle(buttonTitle, for: .normal)
        button.setTitleColor(DS.Colors.darkedTextColor, for: .normal)
        button.titleLabel?.font = UIFont(name: "Manrope-SemiBold", size: 14)
        button.backgroundColor = .clear
        contentView.addSubview(button)
        
        label.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(DS.Constraints.baseInsetViews)
            $0.leading.equalToSuperview()
            $0.height.equalTo(contentView.snp.width).multipliedBy(DS.SizeMultipliers.tenPercent)
        }
        
        button.snp.makeConstraints {
            $0.height.equalTo(contentView.snp.height).multipliedBy(DS.SizeMultipliers.halfSize)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }
}
