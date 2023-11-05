//
//  TaskTVC.swift
//  Atty
//
//  Created by Nikita Melnikov on 02.11.2023.
//

import Foundation
import UIKit
import SnapKit

class TaskTVC: UITableViewCell {
    
    private var view: UIView!
    var taskDescription = UILabel()

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

extension TaskTVC {

    func emptyTasksList() {
        
        view.backgroundColor = DS.Colors.mainBackgroundColor
        let label = UILabel()
        label.text = "На сьогодні задачі відсутні"
        label.textColor = DS.Colors.standartTextColor
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "Manrope-Bold", size: 18)
        view.addSubview(label)

        label.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
    }
    
    func addTask(title: String, completionStatus: Bool) {

        if completionStatus {

            view.backgroundColor = DS.Colors.taskFinished

            let doneIcon = UIImageView()
            doneIcon.image = UIImage(named: "doneIcon")
            view.addSubview(doneIcon)

            taskDescription = UILabel()
            taskDescription.text = title
            taskDescription.textColor = .black
            taskDescription.numberOfLines = 0
            taskDescription.font = UIFont(name: "Manrope-Bold", size: 14)
            view.addSubview(taskDescription)

            doneIcon.snp.makeConstraints {
                $0.top.bottom.equalToSuperview()
                $0.leading.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
                $0.width.equalTo(doneIcon.snp.height)
            }

            taskDescription.snp.makeConstraints {
                $0.top.trailing.bottom.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
                $0.leading.equalTo(doneIcon.snp.trailing)
            }
        } else {

            view.backgroundColor = DS.Colors.taskStarted

            taskDescription = UILabel()
            taskDescription.text = title
            taskDescription.textColor = DS.Colors.standartTextColor
            taskDescription.numberOfLines = 0
            taskDescription.font = UIFont(name: "Manrope-Bold", size: 14)
            view.addSubview(taskDescription)

            taskDescription.snp.makeConstraints {
                $0.edges.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
            }
        }
    }
}
