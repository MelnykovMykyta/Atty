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
    private var disputeSubjectLabel = UILabel()
    private var clientLabel = UILabel()
    private var judgeLabel = UILabel()
    private var timeLabel = UILabel()
    private var dateLabel = UILabel()
    private var archiveIcon = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layer.cornerRadius = DS.CornerRadius.baseCornerRadiusLayers
        layer.masksToBounds = true
        
        backgroundColor = .clear
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension CourtMeetTVC {
    
    private func setupViews() {
        
        view = UIView()
        view.layer.cornerRadius = DS.CornerRadius.baseCornerRadiusLayers
        view.layer.masksToBounds = true
        addSubview(view)
        
        view.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(DS.Constraints.baseInsetViews)
        }
    }
    
    func emptyCourtMeetsList(with title: String) {
        
        view.subviews.forEach { $0.removeFromSuperview() }
        
        view.backgroundColor = DS.Colors.mainViewColor
        
        let label = UILabel()
        label.text = title
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
        
        caseNumberLabel = UILabel()
        caseNumberLabel = UILabel()
        caseNumberLabel.text = caseNumber
        caseNumberLabel.textColor = DS.Colors.standartTextColor
        caseNumberLabel.font = UIFont(name: "Manrope-Bold", size: 20)
        view.addSubview(caseNumberLabel)
        
        plaintiffLabel = UILabel()
        plaintiffLabel.text = "Позивач: \(plaintiff)"
        plaintiffLabel.textColor = DS.Colors.darkedTextColor
        plaintiffLabel.numberOfLines = 0
        plaintiffLabel.font = UIFont(name: "Manrope-ExtraLight", size: 10)
        view.addSubview(plaintiffLabel)
        
        defendantLabel = UILabel()
        defendantLabel.text = "Відповідач: \(defendant)"
        defendantLabel.textColor = DS.Colors.darkedTextColor
        defendantLabel.numberOfLines = 0
        defendantLabel.font = UIFont(name: "Manrope-ExtraLight", size: 10)
        view.addSubview(defendantLabel)
        
        judgeLabel = UILabel()
        judgeLabel.text = "Суддя: \(judge)"
        judgeLabel.textColor = DS.Colors.darkedTextColor
        judgeLabel.numberOfLines = 0
        judgeLabel.font = UIFont(name: "Manrope-ExtraLight", size: 10)
        view.addSubview(judgeLabel)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        view.addSubview(stackView)
        
        timeLabel = UILabel()
        timeLabel.text = time
        timeLabel.textAlignment = .center
        timeLabel.textColor = DS.Colors.taskFinished
        timeLabel.numberOfLines = 0
        timeLabel.font = UIFont(name: "Manrope-Bold", size: 24)
        stackView.addArrangedSubview(timeLabel)
        
        dateLabel = UILabel()
        dateLabel.text = date
        dateLabel.textAlignment = .center
        dateLabel.textColor = DS.Colors.standartTextColor
        dateLabel.numberOfLines = 0
        dateLabel.font = UIFont(name: "Manrope-Bold", size: 18)
        stackView.addArrangedSubview(dateLabel)
        
        courtNameLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
        caseNumberLabel.snp.makeConstraints {
            $0.top.equalTo(courtNameLabel.snp.bottom)
            $0.leading.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
        plaintiffLabel.snp.makeConstraints {
            $0.top.equalTo(caseNumberLabel.snp.bottom).inset(-DS.Constraints.baseInsetViews)
            $0.leading.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
        defendantLabel.snp.makeConstraints {
            $0.top.equalTo(plaintiffLabel.snp.bottom)
            $0.leading.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
        judgeLabel.snp.makeConstraints {
            $0.top.equalTo(defendantLabel.snp.bottom).inset(-DS.Constraints.infoViewLabelInset)
            $0.leading.bottom.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
        stackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
    }
    
    func addCourtCase(courtName: String, caseNumber: String, plaintiff: String, defendant: String, judge: String, status: Bool) {
        
        view.subviews.forEach { $0.removeFromSuperview() }
        
        view.backgroundColor = DS.Colors.mainBackgroundColor
        
        courtNameLabel = UILabel()
        courtNameLabel.text = courtName
        courtNameLabel.textColor = DS.Colors.standartTextColor
        courtNameLabel.font = UIFont(name: "Manrope-Bold", size: 12)
        view.addSubview(courtNameLabel)
        
        caseNumberLabel = UILabel()
        caseNumberLabel = UILabel()
        caseNumberLabel.text = caseNumber
        caseNumberLabel.textColor = DS.Colors.standartTextColor
        caseNumberLabel.font = UIFont(name: "Manrope-Bold", size: 20)
        view.addSubview(caseNumberLabel)
        
        plaintiffLabel = UILabel()
        plaintiffLabel.text = "Позивач: \(plaintiff)"
        plaintiffLabel.textColor = DS.Colors.darkedTextColor
        plaintiffLabel.numberOfLines = 0
        plaintiffLabel.font = UIFont(name: "Manrope-ExtraLight", size: 10)
        view.addSubview(plaintiffLabel)
        
        defendantLabel = UILabel()
        defendantLabel.text = "Відповідач: \(defendant)"
        defendantLabel.textColor = DS.Colors.darkedTextColor
        defendantLabel.numberOfLines = 0
        defendantLabel.font = UIFont(name: "Manrope-ExtraLight", size: 10)
        view.addSubview(defendantLabel)
        
        judgeLabel = UILabel()
        judgeLabel.text = "Суддя: \(judge)"
        judgeLabel.textColor = DS.Colors.darkedTextColor
        judgeLabel.numberOfLines = 0
        judgeLabel.font = UIFont(name: "Manrope-ExtraLight", size: 10)
        view.addSubview(judgeLabel)
        
        courtNameLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
        caseNumberLabel.snp.makeConstraints {
            $0.top.equalTo(courtNameLabel.snp.bottom)
            $0.leading.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
        plaintiffLabel.snp.makeConstraints {
            $0.top.equalTo(caseNumberLabel.snp.bottom).inset(-DS.Constraints.baseInsetViews)
            $0.leading.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
        defendantLabel.snp.makeConstraints {
            $0.top.equalTo(plaintiffLabel.snp.bottom)
            $0.leading.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
        judgeLabel.snp.makeConstraints {
            $0.top.equalTo(defendantLabel.snp.bottom).inset(-DS.Constraints.infoViewLabelInset)
            $0.leading.bottom.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
        if status {
            
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
    
    func addFullCourtCase(courtName: String, caseNumber: String, plaintiff: String, defendant: String, disputeSubject: String, client: String, judge: String) {
        
        view.subviews.forEach { $0.removeFromSuperview() }
        
        view.backgroundColor = DS.Colors.mainBackgroundColor
        
        courtNameLabel = UILabel()
        courtNameLabel.text = courtName
        courtNameLabel.textColor = DS.Colors.standartTextColor
        courtNameLabel.font = UIFont(name: "Manrope-Bold", size: 12)
        view.addSubview(courtNameLabel)
        
        caseNumberLabel = UILabel()
        caseNumberLabel = UILabel()
        caseNumberLabel.text = caseNumber
        caseNumberLabel.textColor = DS.Colors.standartTextColor
        caseNumberLabel.font = UIFont(name: "Manrope-Bold", size: 20)
        view.addSubview(caseNumberLabel)
        
        plaintiffLabel = UILabel()
        plaintiffLabel.text = "Позивач: \(plaintiff)"
        plaintiffLabel.textColor = DS.Colors.darkedTextColor
        plaintiffLabel.numberOfLines = 0
        plaintiffLabel.font = UIFont(name: "Manrope-ExtraLight", size: 10)
        view.addSubview(plaintiffLabel)
        
        defendantLabel = UILabel()
        defendantLabel.text = "Відповідач: \(defendant)"
        defendantLabel.textColor = DS.Colors.darkedTextColor
        defendantLabel.numberOfLines = 0
        defendantLabel.font = UIFont(name: "Manrope-ExtraLight", size: 10)
        view.addSubview(defendantLabel)
        
        disputeSubjectLabel = UILabel()
        disputeSubjectLabel.text = "Предмет: \(disputeSubject)"
        disputeSubjectLabel.textColor = DS.Colors.darkedTextColor
        disputeSubjectLabel.numberOfLines = 0
        disputeSubjectLabel.font = UIFont(name: "Manrope-ExtraLight", size: 10)
        view.addSubview(disputeSubjectLabel)
        
        judgeLabel = UILabel()
        judgeLabel.text = "Суддя: \(judge)"
        judgeLabel.textColor = DS.Colors.darkedTextColor
        judgeLabel.numberOfLines = 0
        judgeLabel.font = UIFont(name: "Manrope-ExtraLight", size: 10)
        view.addSubview(judgeLabel)
        
        clientLabel = UILabel()
        clientLabel.text = "Клієнт: \(client)"
        clientLabel.textColor = DS.Colors.darkedTextColor
        clientLabel.numberOfLines = 0
        clientLabel.font = UIFont(name: "Manrope-ExtraLight", size: 10)
        view.addSubview(clientLabel)
        
        courtNameLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
        caseNumberLabel.snp.makeConstraints {
            $0.top.equalTo(courtNameLabel.snp.bottom)
            $0.leading.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
        plaintiffLabel.snp.makeConstraints {
            $0.top.equalTo(caseNumberLabel.snp.bottom).inset(-DS.Constraints.baseInsetViews)
            $0.leading.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
        defendantLabel.snp.makeConstraints {
            $0.top.equalTo(plaintiffLabel.snp.bottom)
            $0.leading.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
        defendantLabel.snp.makeConstraints {
            $0.top.equalTo(defendantLabel.snp.bottom)
            $0.leading.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
        judgeLabel.snp.makeConstraints {
            $0.top.equalTo(defendantLabel.snp.bottom)
            $0.leading.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
        clientLabel.snp.makeConstraints {
            $0.top.equalTo(judgeLabel.snp.bottom).inset(-DS.Constraints.infoViewLabelInset)
            $0.leading.bottom.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
    }
}
