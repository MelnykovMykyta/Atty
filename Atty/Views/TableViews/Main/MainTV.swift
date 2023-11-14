//
//  MainTV.swift
//  Atty
//
//  Created by Nikita Melnikov on 02.11.2023.
//

import Foundation
import UIKit
import SnapKit
import RxCocoa
import RxSwift

class MainTV: UITableView {
    
    private var disposeBag = DisposeBag()
    
    private let header = "HeaderTVC"
    private let task = "TaskTVC"
    private let meet = "CourtMeetTVC"
    
    private var tasks: [Task] = TasksViewModel.getTasksWithTodayDeadline()
    private var courtMeets: [CourtMeet] = CourtsViewModel.allMeets
        .sorted(by: { $0.date < $1.date })
        .filter { DateHelper.compareDates(date: $0.date) }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        TasksViewModel.observeTasks().subscribe(onNext: { event in
            self.tasks = TasksViewModel.getTasksWithTodayDeadline()
            self.reloadData()
        }).disposed(by: disposeBag)
        
        CourtsViewModel.meetsSubject.subscribe(onNext: { event in
            self.courtMeets = CourtsViewModel.allMeets
                .sorted(by: { $0.date < $1.date })
                .filter { DateHelper.compareDates(date: $0.date) }
            self.reloadData()
        }).disposed(by: disposeBag)
        
        self.delegate = self
        self.dataSource = self
        
        separatorStyle = .none
        allowsSelection = false
        showsVerticalScrollIndicator = false
        backgroundColor = .clear
        
        self.register(HeaderTVC.self, forCellReuseIdentifier: header)
        self.register(TaskTVC.self, forCellReuseIdentifier: task)
        self.register(CourtMeetTVC.self, forCellReuseIdentifier: meet)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension MainTV: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        case 1:
            return tasks.isEmpty ? 1 : tasks.count
        case 3:
            return courtMeets.isEmpty ? 1 : courtMeets.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderTVC") as? HeaderTVC,
              let tasksCell = tableView.dequeueReusableCell(withIdentifier: "TaskTVC") as? TaskTVC,
              let meetCell = tableView.dequeueReusableCell(withIdentifier: "CourtMeetTVC") as? CourtMeetTVC
        else { return UITableViewCell() }
        
        switch indexPath.section {
            
        case 0:
            headerCell.addTitle(title: "Дедлайни")
            return headerCell
            
        case 1:
            if tasks.isEmpty {
                tasksCell.emptyTodayTasksList()
            } else {
                tasksCell.addTask(title: tasks[indexPath.row].desc, completionStatus: tasks[indexPath.row].status)
            }
            return tasksCell
            
        case 2:
            headerCell.addTitle(title: "Засідання")
            return headerCell
            
        case 3:
            
            if courtMeets.isEmpty {
                meetCell.emptyCourtMeetsList(with: "На сьогодні засідання відсутні")
            } else {
                let meet = courtMeets[indexPath.row]
                meetCell.addCourtMeet(courtName: meet.courtName, caseNumber: meet.caseNumber, plaintiff: meet.plaintiff,defendant: meet.defendant, judge: meet.judge, time: meet.time, date: meet.day)
            }
            return meetCell
            
        case 4:
            headerCell.addViews(title: "Новини", buttonTitle: "Більше")
            headerCell.button.addTarget(self, action: #selector(allNews), for: .touchUpInside)
            return headerCell
        case 5:
            return headerCell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard indexPath.section == 1 && !tasks.isEmpty else {  return UISwipeActionsConfiguration() }
        let swipe = UIContextualAction(style: .destructive, title: "Не виконано") { (action, view, success) in
            let task = self.tasks[indexPath.row]
            TasksViewModel.updateTaskStatus(with: task, status: false)
            success(true)
        }
        return UISwipeActionsConfiguration(actions: [swipe])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard indexPath.section == 1 && !tasks.isEmpty  else {  return UISwipeActionsConfiguration() }
        let swipe = UIContextualAction(style: .destructive, title: "Виконано") { (action, view, success) in
            let task = self.tasks[indexPath.row]
            TasksViewModel.updateTaskStatus(with: task, status: true)
            success(true)
        }
        swipe.backgroundColor = DS.Colors.taskFinished
        
        return UISwipeActionsConfiguration(actions: [swipe])
    }
    
    @objc func allNews(_ sender: UIButton) {
        print("ALL NEWS")
    }
}
