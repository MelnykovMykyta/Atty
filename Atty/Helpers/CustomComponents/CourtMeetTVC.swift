//
//  CourtMeetTVC.swift
//  Atty
//
//  Created by Nikita Melnikov on 05.11.2023.
//

import Foundation
import UIKit
import SnapKit

class CourtMeetTVC: UITableViewCell {
    
    private var view: UIView!
    private var courtNameLabel = UILabel()
    private var caseNumberLabel = UILabel()
    private var plaintiffLabel = UILabel()
    private var defendantLabel = UILabel()
    private var judgeLabel = UILabel()
    private var timeLabel = UILabel()
    private var dateLabel = UILabel()
    
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

extension CourtMeetTVC {
    
    func emptyCourtMeetsList() {
        
        view.subviews.forEach { $0.removeFromSuperview() }
        
        view.backgroundColor = DS.Colors.mainViewColor
        
        let label = UILabel()
        label.text = "На сьогодні засідання відсутні"
        label.textColor = DS.Colors.standartTextColor
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "Manrope-Bold", size: 14)
        view.addSubview(label)
        
        label.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
    }
    
    func addCourtMeet(courtName: String, caseNumber: String, plaintiff: String, defendant: String, judge: String, time: String, date: String) {
        
        view.subviews.forEach { $0.removeFromSuperview() }
        
        view.backgroundColor = DS.Colors.mainBackgroundColor
        
        courtNameLabel = UILabel()
        courtNameLabel.text = courtName
        courtNameLabel.textColor = DS.Colors.standartTextColor
        courtNameLabel.font = UIFont(name: "Manrope-Bold", size: 12)
        view.addSubview(courtNameLabel)
        
        courtNameLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
        caseNumberLabel = UILabel()
        caseNumberLabel = UILabel()
        caseNumberLabel.text = caseNumber
        caseNumberLabel.textColor = DS.Colors.standartTextColor
        caseNumberLabel.font = UIFont(name: "Manrope-Bold", size: 20)
        view.addSubview(caseNumberLabel)
        
        caseNumberLabel.snp.makeConstraints {
            $0.top.equalTo(courtNameLabel.snp.bottom)
            $0.leading.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
        plaintiffLabel = UILabel()
        plaintiffLabel.text = "Позивач: \(plaintiff)"
        plaintiffLabel.textColor = DS.Colors.darkedTextColor
        plaintiffLabel.numberOfLines = 0
        plaintiffLabel.font = UIFont(name: "Manrope-ExtraLight", size: 10)
        view.addSubview(plaintiffLabel)
        
        plaintiffLabel.snp.makeConstraints {
            $0.top.equalTo(caseNumberLabel.snp.bottom).inset(-8)
            $0.leading.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
        defendantLabel = UILabel()
        defendantLabel.text = "Відповідач: \(defendant)"
        defendantLabel.textColor = DS.Colors.darkedTextColor
        defendantLabel.numberOfLines = 0
        defendantLabel.font = UIFont(name: "Manrope-ExtraLight", size: 10)
        view.addSubview(defendantLabel)
        
        defendantLabel.snp.makeConstraints {
            $0.top.equalTo(plaintiffLabel.snp.bottom)
            $0.leading.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
        judgeLabel = UILabel()
        judgeLabel.text = "Суддя: \(judge)"
        judgeLabel.textColor = DS.Colors.darkedTextColor
        judgeLabel.numberOfLines = 0
        judgeLabel.font = UIFont(name: "Manrope-ExtraLight", size: 10)
        view.addSubview(judgeLabel)
        
        judgeLabel.snp.makeConstraints {
            $0.top.equalTo(defendantLabel.snp.bottom).inset(-4)
            $0.leading.bottom.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
        timeLabel = UILabel()
        timeLabel.text = time
        timeLabel.textAlignment = .center
        timeLabel.textColor = DS.Colors.taskFinished
        timeLabel.numberOfLines = 0
        timeLabel.font = UIFont(name: "Manrope-Bold", size: 24)
        
        dateLabel = UILabel()
        dateLabel.text = date
        dateLabel.textAlignment = .center
        dateLabel.textColor = DS.Colors.standartTextColor
        dateLabel.numberOfLines = 0
        dateLabel.font = UIFont(name: "Manrope-Bold", size: 18)
        
        stackView.addArrangedSubview(timeLabel)
        stackView.addArrangedSubview(dateLabel)
    }
}

