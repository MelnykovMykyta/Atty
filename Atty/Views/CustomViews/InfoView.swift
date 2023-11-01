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
    private var mainInfoView: UIView!
    private var additionallyInfoView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraintViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    }
    
    private func setupConstraintViews(){
        
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
    
    func setMainTodayInfo(date: String, todayTasksValue: Int, todayCourtMeets: Int) {
        
        let dateLabel = UILabel()
        dateLabel.text = date
        dateLabel.textColor = DS.Colors.standartTextColor
        dateLabel.font = UIFont(name: "Manrope-Bold", size: 100)
        dateLabel.adjustsFontSizeToFitWidth = true
        mainInfoView.addSubview(dateLabel)
        
        let labelsStackView = UIStackView()
        labelsStackView.axis = .horizontal
        labelsStackView.alignment = .leading
        labelsStackView.spacing = 8
        labelsStackView.distribution = .fillProportionally
        mainInfoView.addSubview(labelsStackView)
        
        let tasksView = UIView()
        labelsStackView.addArrangedSubview(tasksView)
        
        let tasksIcon = UIImageView()
        tasksIcon.image = UIImage(named: "tasksInfoIcon")
        tasksView.addSubview(tasksIcon)
        
        let tasksLabel = UILabel()
        tasksLabel.text = "Задачі"
        tasksLabel.textColor = DS.Colors.standartTextColor
        tasksLabel.font = UIFont(name: "Manrope-Bold", size: 80)
        tasksLabel.adjustsFontSizeToFitWidth = true
        tasksView.addSubview(tasksLabel)
        
        let courtMeetView = UIView()
        labelsStackView.addArrangedSubview(courtMeetView)
        
        let courtMeetIcon = UIImageView()
        courtMeetIcon.image = UIImage(named: "courtMeetInfoIcon")
        courtMeetView.addSubview(courtMeetIcon)
        
        let courtMeetLabel = UILabel()
        courtMeetLabel.text = "Засідання"
        courtMeetLabel.textColor = DS.Colors.standartTextColor
        courtMeetLabel.font = UIFont(name: "Manrope-Bold", size: 80)
        courtMeetLabel.adjustsFontSizeToFitWidth = true
        courtMeetView.addSubview(courtMeetLabel)
        
        let tasksValue = UILabel()
        tasksValue.text = todayTasksValue.description
        tasksValue.textColor = DS.Colors.standartTextColor
        tasksValue.font = UIFont(name: "Manrope-Bold", size: 80)
        tasksValue.textAlignment = .center
        tasksValue.adjustsFontSizeToFitWidth = true
        mainInfoView.addSubview(tasksValue)
        
        let courtMeetsValue = UILabel()
        courtMeetsValue.text = todayCourtMeets.description
        courtMeetsValue.textColor = DS.Colors.standartTextColor
        courtMeetsValue.font = UIFont(name: "Manrope-Bold", size: 80)
        courtMeetsValue.textAlignment = .center
        courtMeetsValue.adjustsFontSizeToFitWidth = true
        mainInfoView.addSubview(courtMeetsValue)
        
        dateLabel.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(DS.SizeMultipliers.twentyPercent)
            $0.top.leading.trailing.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
        labelsStackView.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(DS.SizeMultipliers.fifteenPercent)
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
        tasksIcon.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.width.equalTo(tasksIcon.snp.height)
        }
        
        tasksLabel.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(DS.SizeMultipliers.eightyPercent)
            $0.trailing.equalToSuperview()
            $0.leading.equalTo(tasksIcon.snp.trailing).inset(-DS.Constraints.infoViewLabelInset)
            $0.centerY.equalTo(tasksIcon.snp.centerY)
        }
        
        courtMeetIcon.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.width.equalTo(courtMeetIcon.snp.height)
        }
        
        courtMeetLabel.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(DS.SizeMultipliers.eightyPercent)
            $0.trailing.equalToSuperview()
            $0.leading.equalTo(courtMeetIcon.snp.trailing).inset(-DS.Constraints.infoViewLabelInset)
            $0.centerY.equalTo(courtMeetIcon.snp.centerY)
        }
        
        tasksValue.snp.makeConstraints {
            $0.centerX.equalTo(tasksView.snp.centerX)
            $0.top.equalTo(labelsStackView.snp.bottom)
            $0.bottom.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
        courtMeetsValue.snp.makeConstraints {
            $0.centerX.equalTo(courtMeetView.snp.centerX)
            $0.top.equalTo(labelsStackView.snp.bottom)
            $0.bottom.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
    }
    
    func setCostsView() {
        let costsIcon = UIImageView()
        costsIcon.image = UIImage(named: "costsIcon")
        additionallyInfoView.addSubview(costsIcon)
        
        let costsLabel = UILabel()
        costsLabel.text = "Витрати"
        costsLabel.textColor = DS.Colors.standartTextColor
        costsLabel.font = UIFont(name: "Manrope-Bold", size: 80)
        costsLabel.adjustsFontSizeToFitWidth = true
        additionallyInfoView.addSubview(costsLabel)
        
        let scheduleIcon = UIImageView()
        scheduleIcon.image = UIImage(named: "scheduleIcon")
        additionallyInfoView.addSubview(scheduleIcon)
        
        let bottomView = UIView()
        bottomView.backgroundColor = DS.Colors.lightGray
        bottomView.layer.cornerRadius = DS.CornerRadius.baseCornerRadiusLayers
        bottomView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        additionallyInfoView.addSubview(bottomView)
        
        let detailsLabel = UILabel()
        detailsLabel.text = "Детальніше"
        detailsLabel.textColor = DS.Colors.darkedTextColor
        detailsLabel.font = UIFont(name: "Manrope-Bold", size: 80)
        detailsLabel.adjustsFontSizeToFitWidth = true
        bottomView.addSubview(detailsLabel)
        
        let arrowIcon = UIImageView()
        arrowIcon.image = UIImage(named: "arrowRight")
        bottomView.addSubview(arrowIcon)
        
        costsIcon.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(DS.SizeMultipliers.fifteenPercent)
            $0.width.equalTo(costsIcon.snp.height)
            $0.top.leading.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
        costsLabel.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(DS.SizeMultipliers.fifteenPercent)
            $0.leading.equalTo(costsIcon.snp.trailing).inset(-DS.Constraints.infoViewLabelInset)
            $0.trailing.equalToSuperview()
            $0.centerY.equalTo(costsIcon.snp.centerY)
        }
        
        bottomView.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(DS.SizeMultipliers.quarterSize)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        detailsLabel.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(DS.SizeMultipliers.halfSize)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
        arrowIcon.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(DS.SizeMultipliers.fortyPercent)
            $0.width.equalTo(arrowIcon.snp.height).multipliedBy(DS.SizeMultipliers.halfSize)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
        scheduleIcon.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(DS.SizeMultipliers.fortyPercent)
            $0.bottom.equalTo(bottomView.snp.top)
            $0.leading.trailing.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
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
    
    func setInfoWithValueFrom(title: String, value: Int, from: Int) {
        let label = UILabel()
        label.text = title
        label.textColor = DS.Colors.standartTextColor
        label.font = UIFont(name: "Manrope-Bold", size: 100)
        label.adjustsFontSizeToFitWidth = true
        mainInfoView.addSubview(label)
        
        let valueLabel = UILabel()
        valueLabel.text = "\(value.description) / \(from.description)"
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
            $0.height.equalToSuperview().multipliedBy(DS.SizeMultipliers.fortyPercent)
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
