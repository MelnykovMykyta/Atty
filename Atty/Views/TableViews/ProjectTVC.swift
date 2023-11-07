//
//  ProjectTVC.swift
//  Atty
//
//  Created by Nikita Melnikov on 07.11.2023.
//

import Foundation
import UIKit
import SnapKit

class ProjectTVC: UITableViewCell {
    
    private var doneIcon = UIImageView()
    private var view: UIView!
    private var projectNameLabel = UILabel()
    private var clientNameLabel = UILabel()
    private var categoryLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layer.cornerRadius = DS.CornerRadius.baseCornerRadiusLayers
        layer.masksToBounds = true
        
        backgroundColor = .clear
        
        view = UIView()
        view.layer.cornerRadius = DS.CornerRadius.baseCornerRadiusLayers
        view.layer.masksToBounds = true
        addSubview(view)
        view.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(DS.Constraints.infoViewLabelInset)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProjectTVC {
    
    func addProject(projectName: String, clientName: String, category: String, completionStatus: Bool) {
        
        view.subviews.forEach { $0.removeFromSuperview() }
        
        view.backgroundColor = DS.Colors.taskStarted
        
        projectNameLabel = UILabel()
        projectNameLabel.text = projectName
        projectNameLabel.textColor = DS.Colors.standartTextColor
        projectNameLabel.numberOfLines = 0
        projectNameLabel.font = UIFont(name: "Manrope-Bold", size: 16)
        view.addSubview(projectNameLabel)
        
        clientNameLabel = UILabel()
        clientNameLabel.text = "Клієнт: \(clientName)"
        clientNameLabel.textColor = DS.Colors.darkedTextColor
        clientNameLabel.numberOfLines = 0
        clientNameLabel.font = UIFont(name: "Manrope-ExtraLight", size: 12)
        view.addSubview(clientNameLabel)
        
        categoryLabel = UILabel()
        categoryLabel.text = "Категорія: \(category)"
        categoryLabel.textColor = DS.Colors.darkedTextColor
        categoryLabel.numberOfLines = 0
        categoryLabel.font = UIFont(name: "Manrope-ExtraLight", size: 12)
        view.addSubview(categoryLabel)
        
        projectNameLabel.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(DS.SizeMultipliers.seventyPercent)
            $0.top.leading.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
        clientNameLabel.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(DS.SizeMultipliers.seventyPercent)
            $0.top.equalTo(projectNameLabel.snp.bottom).inset(-DS.Constraints.authViewLeadinTrailing)
            $0.leading.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
        categoryLabel.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(DS.SizeMultipliers.seventyPercent)
            $0.top.equalTo(clientNameLabel.snp.bottom)
            $0.leading.bottom.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
        if completionStatus {
            
            view.backgroundColor = DS.Colors.taskFinished
            
            [projectNameLabel, clientNameLabel, categoryLabel].forEach { $0.textColor = .black }
            
            doneIcon = UIImageView()
            doneIcon.image = UIImage(named: "doneIcon")
            view.addSubview(doneIcon)
            
            doneIcon.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.trailing.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
                $0.size.equalTo(20)
            }
        }
    }
    func emptyProjectsList() {
        
        view.subviews.forEach { $0.removeFromSuperview() }
        
        view.backgroundColor = DS.Colors.mainViewColor
        
        let label = UILabel()
        label.text = "Ви ще не додали жодного проєкта"
        label.textColor = DS.Colors.standartTextColor
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "Manrope-Bold", size: 14)
        view.addSubview(label)
        
        label.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
    }
    
}

