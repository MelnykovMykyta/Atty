//
//  TasksVC.swift
//  Atty
//
//  Created by Nikita Melnikov on 26.10.2023.
//

import Foundation
import UIKit
import SnapKit
import FirebaseAuth
import RxCocoa
import RxSwift
import BetterSegmentedControl

class TasksVC: BaseViewContoller {
    
    private var disposeBag = DisposeBag()
    
    private var nextbtn: UIButton!
    private var valueLabel: UILabel!
    private var valueFromLabel: UILabel!
    private var segmentController: BetterSegmentedControl!
    private var tableView: UITableView!
    
    private let tasks = TasksTV()
    private let tasksByClient = TasksByClientTV()
    private let doneTasks = DoneTasksTV()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        addSegmentController()
        
        addTable(with: TasksTV())
        
        infoView.setAddView(title: "Додати задачу")
        infoView.addInfoButton()
        infoView.infoButton.addTarget(self, action: #selector(addNewTask), for: .touchUpInside)
        
        
        TasksViewModel.shared.observeTasks().subscribe(onNext: { event in
            let count = event.filter { $0.status == true }.count.description
            let allCount = event.count.description
            self.valueLabel.text = count
            self.valueFromLabel.text = allCount
        }).disposed(by: disposeBag)
    }
}

private extension TasksVC {
    
    func addViews() {
        
        navigationBar.addTitle(with: Tabs.tasks.itemTitle)
        
        let label = UILabel()
        label.text = "Завершені"
        label.textColor = DS.Colors.standartTextColor
        label.font = UIFont(name: "Manrope-Bold", size: 100)
        label.adjustsFontSizeToFitWidth = true
        infoView.mainInfoView.addSubview(label)
        
        let separator = UILabel()
        separator.text = "/"
        separator.textColor = DS.Colors.standartTextColor
        separator.textAlignment = .center
        separator.font = UIFont(name: "Manrope-Bold", size: 100)
        separator.adjustsFontSizeToFitWidth = true
        infoView.mainInfoView.addSubview(separator)
        
        valueLabel = UILabel()
        valueLabel.textColor = DS.Colors.standartTextColor
        valueLabel.textAlignment = .right
        valueLabel.font = UIFont(name: "Manrope-Bold", size: 100)
        valueLabel.adjustsFontSizeToFitWidth = true
        infoView.mainInfoView.addSubview(valueLabel)
        
        valueFromLabel = UILabel()
        valueFromLabel.textColor = DS.Colors.standartTextColor
        valueFromLabel.textAlignment = .left
        valueFromLabel.font = UIFont(name: "Manrope-Bold", size: 100)
        valueFromLabel.adjustsFontSizeToFitWidth = true
        infoView.mainInfoView.addSubview(valueFromLabel)
        
        label.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(DS.SizeMultipliers.twentyPercent)
            $0.top.leading.trailing.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
        separator.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(DS.SizeMultipliers.fortyPercent)
            $0.top.equalTo(label.snp.bottom).inset(-DS.Constraints.authTFSpacing)
            $0.centerX.equalToSuperview()
        }
        valueLabel.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(DS.SizeMultipliers.fortyPercent)
            $0.top.equalTo(label.snp.bottom).inset(-DS.Constraints.authTFSpacing)
            $0.leading.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
            $0.trailing.equalTo(separator.snp.leading)
        }
        
        valueFromLabel.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(DS.SizeMultipliers.fortyPercent)
            $0.top.equalTo(label.snp.bottom).inset(-DS.Constraints.authTFSpacing)
            $0.leading.equalTo(separator.snp.trailing)
            $0.trailing.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
    }
    
    @objc func addNewTask() {
        let vc = AddTaskVC()
        present(vc, animated: true, completion: nil)
    }
    
    func addSegmentController() {
        
        segmentController = BetterSegmentedControl()
        contentView.addSubview(segmentController)
        segmentController.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(DS.SizeMultipliers.eightyPercent)
            $0.top.equalTo(infoView.snp.bottom).inset(-DS.Constraints.authViewLeadinTrailing)
            $0.leading.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
            $0.height.equalTo(contentView.snp.width).multipliedBy(DS.SizeMultipliers.tenPercent)
        }
        
        segmentController.segments = LabelSegment.segments(withTitles: ["Всі задачі", "По клієнтам", "Виконані"],
                                                           normalBackgroundColor: DS.Colors.mainViewColor,
                                                           normalFont: UIFont(name: "Manrope-Bold", size: 14),
                                                           normalTextColor: DS.Colors.darkedTextColor,
                                                           selectedBackgroundColor: DS.Colors.selectedSegmentControllerItem,
                                                           selectedFont: UIFont(name: "Manrope-Bold", size: 14),
                                                           selectedTextColor: DS.Colors.standartTextColor)
        
        segmentController.cornerRadius = segmentController.frame.height / 2
        segmentController.backgroundColor = DS.Colors.mainViewColor
        segmentController.indicatorViewBackgroundColor = DS.Colors.mainViewColor
        segmentController.indicatorViewBorderColor = DS.Colors.mainViewColor
        segmentController.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
    }
    
    func addTable(with table: UITableView) {
        tableView = table
        contentView.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(segmentController.snp.bottom).inset(-DS.Constraints.authViewLeadinTrailing)
            $0.leading.trailing.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
            $0.bottom.equalToSuperview()
        }
    }
    
    @objc func segmentedControlValueChanged(_ sender: BetterSegmentedControl) {
        
        tableView.removeFromSuperview()
        
        switch sender.index {
        case 0:
            addTable(with: tasks)
        case 1:
            addTable(with: tasksByClient)
        case 2:
            addTable(with: doneTasks)
        default:
            return
        }
    }
}
