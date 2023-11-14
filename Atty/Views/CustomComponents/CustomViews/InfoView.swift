//
//  InfoView.swift
//  Atty
//
//  Created by Nikita Melnikov on 31.10.2023.
//

import Foundation
import UIKit
import SnapKit

class InfoView: UIView {
    
    var infoButton = UIButton()
    var mainInfoView: UIView!
    var additionallyInfoView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension InfoView {
    
    private func setupViews(){
        
        backgroundColor = .clear
        
        mainInfoView = UIView()
        mainInfoView.backgroundColor = DS.Colors.mainInfoView
        mainInfoView.layer.cornerRadius = DS.CornerRadius.baseCornerRadiusLayers
        mainInfoView.layer.masksToBounds = true
        addSubview(mainInfoView)
        
        additionallyInfoView = UIView()
        additionallyInfoView.backgroundColor = DS.Colors.additionallyInfoView
        additionallyInfoView.layer.cornerRadius = DS.CornerRadius.baseCornerRadiusLayers
        additionallyInfoView.layer.masksToBounds = true
        addSubview(additionallyInfoView)
        
        mainInfoView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(DS.Constraints.baseInsetViews)
            $0.width.equalToSuperview().multipliedBy(DS.SizeMultipliers.mainInfoViewWidth)
            $0.height.equalTo(mainInfoView.snp.width).multipliedBy(DS.SizeMultipliers.mainInfoViewHeidht)
        }
        
        additionallyInfoView.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview().inset(DS.Constraints.baseInsetViews)
            $0.leading.equalTo(mainInfoView.snp.trailing).inset(-DS.Constraints.baseInsetViews)
        }
    }
    
    func addInfoButton() {
        infoButton = UIButton(type: .system)
        infoButton.layer.cornerRadius = DS.CornerRadius.baseCornerRadiusLayers
        infoButton.layer.masksToBounds = true
        additionallyInfoView.addSubview(infoButton)
        
        infoButton.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    func setInfo(title: String, value: Int) {
        let label = UILabel()
        label.text = title
        label.textColor = DS.Colors.standartTextColor
        label.font = UIFont(name: "Manrope-Bold", size: 100)
        label.adjustsFontSizeToFitWidth = true
        mainInfoView.addSubview(label)
        
        let valueLabel = UILabel()
        valueLabel.text = value.description
        valueLabel.textColor = DS.Colors.standartTextColor
        valueLabel.textAlignment = .center
        valueLabel.font = UIFont(name: "Manrope-Bold", size: 100)
        valueLabel.adjustsFontSizeToFitWidth = true
        mainInfoView.addSubview(valueLabel)
        
        label.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(DS.SizeMultipliers.twentyPercent)
            $0.top.leading.trailing.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
        valueLabel.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(DS.SizeMultipliers.halfSize)
            $0.top.equalTo(label.snp.bottom).inset(-DS.Constraints.authTFSpacing)
            $0.leading.trailing.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
    }
    
    func setAddView(title: String) {
        
        let addViewLabel = UILabel()
        addViewLabel.text = title
        addViewLabel.textColor = DS.Colors.standartTextColor
        addViewLabel.font = UIFont(name: "Manrope-Bold", size: 80)
        addViewLabel.adjustsFontSizeToFitWidth = true
        additionallyInfoView.addSubview(addViewLabel)
        
        let plusIcon = UIImageView()
        plusIcon.image = UIImage(named: "plusIcon")
        additionallyInfoView.addSubview(plusIcon)
        
        addViewLabel.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(DS.SizeMultipliers.fifteenPercent)
            $0.top.leading.trailing.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
        plusIcon.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(DS.SizeMultipliers.fortyPercent)
            $0.top.equalTo(addViewLabel.snp.bottom).inset(-DS.Constraints.authViewLeadinTrailing)
            $0.width.equalTo(plusIcon.snp.height)
            $0.centerX.equalToSuperview()
        }
    }
}
