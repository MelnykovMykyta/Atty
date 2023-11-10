//
//  ClientTVC.swift
//  Atty
//
//  Created by Nikita Melnikov on 09.11.2023.
//

import Foundation
import UIKit
import SnapKit

class ClientTVC: UITableViewCell {
    
    private var archiveIcon = UIImageView()
    private var view: UIView!
    private var clientNameLabel = UILabel()
    private var contactLabel = UILabel()
    private var projectsLabel = UILabel()
    private var contactPersonLabel = UILabel()
    private var emailLabel = UILabel()
    private var idCodeLabel = UILabel()
    
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
            $0.edges.equalToSuperview().inset(DS.Constraints.baseInsetViews)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension ClientTVC {
    
    func addClient(clientName: String, contact: String, projects: String, completionStatus: Bool) {
        
        view.subviews.forEach { $0.removeFromSuperview() }
        
        view.backgroundColor = DS.Colors.taskStarted
        
        clientNameLabel = UILabel()
        clientNameLabel.text = clientName
        clientNameLabel.textColor = DS.Colors.standartTextColor
        clientNameLabel.numberOfLines = 0
        clientNameLabel.font = UIFont(name: "Manrope-Bold", size: 16)
        view.addSubview(clientNameLabel)
        
        contactLabel = UILabel()
        contactLabel.text = "Контакти: \(contact)"
        contactLabel.textColor = DS.Colors.darkedTextColor
        contactLabel.numberOfLines = 0
        contactLabel.font = UIFont(name: "Manrope-ExtraLight", size: 12)
        view.addSubview(contactLabel)
        
        projectsLabel = UILabel()
        projectsLabel.text = "Проєкти: \(projects)"
        projectsLabel.textColor = DS.Colors.darkedTextColor
        projectsLabel.numberOfLines = 0
        projectsLabel.font = UIFont(name: "Manrope-ExtraLight", size: 12)
        view.addSubview(projectsLabel)
        
        clientNameLabel.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(DS.SizeMultipliers.seventyPercent)
            $0.top.leading.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
        contactLabel.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(DS.SizeMultipliers.seventyPercent)
            $0.top.equalTo(clientNameLabel.snp.bottom).inset(-DS.Constraints.authTFSpacing)
            $0.leading.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
        projectsLabel.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(DS.SizeMultipliers.seventyPercent)
            $0.top.equalTo(contactLabel.snp.bottom)
            $0.leading.bottom.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
        if completionStatus {
            
            view.backgroundColor = DS.Colors.archiveColor
            
            archiveIcon = UIImageView()
            archiveIcon.image = UIImage(named: "archiveIcon")
            view.addSubview(archiveIcon)
            
            archiveIcon.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.trailing.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
                $0.size.equalTo(DS.Sizes.buttonSize)
            }
        }
    }
    
    func addFullClient(clientName: String, contactPerson: String, contact: String, email: String, idCode: String) {
        
        view.subviews.forEach { $0.removeFromSuperview() }
        
        view.backgroundColor = DS.Colors.taskStarted
        
        clientNameLabel = UILabel()
        clientNameLabel.text = clientName
        clientNameLabel.textColor = DS.Colors.standartTextColor
        clientNameLabel.numberOfLines = 0
        clientNameLabel.font = UIFont(name: "Manrope-Bold", size: 16)
        view.addSubview(clientNameLabel)
        
        contactPersonLabel = UILabel()
        contactPersonLabel.text = "Контактна особа: \(contactPerson)"
        contactPersonLabel.textColor = DS.Colors.darkedTextColor
        contactPersonLabel.numberOfLines = 0
        contactPersonLabel.font = UIFont(name: "Manrope-ExtraLight", size: 12)
        view.addSubview(contactPersonLabel)
        
        contactLabel = UILabel()
        contactLabel.text = "Контакти: \(contact)"
        contactLabel.textColor = DS.Colors.darkedTextColor
        contactLabel.numberOfLines = 0
        contactLabel.font = UIFont(name: "Manrope-ExtraLight", size: 12)
        view.addSubview(contactLabel)
        
        emailLabel = UILabel()
        emailLabel.text = "Email: \(email)"
        emailLabel.textColor = DS.Colors.darkedTextColor
        emailLabel.numberOfLines = 0
        emailLabel.font = UIFont(name: "Manrope-ExtraLight", size: 12)
        view.addSubview(emailLabel)
        
        idCodeLabel = UILabel()
        idCodeLabel.text = "Ідентифікаційний код: \(idCode)"
        idCodeLabel.textColor = DS.Colors.darkedTextColor
        idCodeLabel.numberOfLines = 0
        idCodeLabel.font = UIFont(name: "Manrope-ExtraLight", size: 12)
        view.addSubview(idCodeLabel)
        
        clientNameLabel.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(DS.SizeMultipliers.seventyPercent)
            $0.top.leading.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
        contactPersonLabel.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(DS.SizeMultipliers.seventyPercent)
            $0.top.equalTo(clientNameLabel.snp.bottom).inset(-DS.Constraints.authTFSpacing)
            $0.leading.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
        contactLabel.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(DS.SizeMultipliers.seventyPercent)
            $0.top.equalTo(contactPersonLabel.snp.bottom)
            $0.leading.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
        emailLabel.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(DS.SizeMultipliers.seventyPercent)
            $0.top.equalTo(contactLabel.snp.bottom).inset(-DS.Constraints.authTFSpacing)
            $0.leading.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
        idCodeLabel.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(DS.SizeMultipliers.seventyPercent)
            $0.top.equalTo(emailLabel.snp.bottom)
            $0.leading.bottom.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
    }
    
    func emptyClientsList() {
        
        view.subviews.forEach { $0.removeFromSuperview() }
        
        view.backgroundColor = DS.Colors.mainViewColor
        
        let label = UILabel()
        label.text = "Додайте актуального клієнта"
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
