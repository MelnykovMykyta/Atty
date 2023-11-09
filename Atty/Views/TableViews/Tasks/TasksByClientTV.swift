//
//  TasksByClientTV.swift
//  Atty
//
//  Created by Nikita Melnikov on 09.11.2023.
//

import Foundation
import UIKit
import SnapKit
import RxCocoa
import RxSwift

class TasksByClientTV: UITableView {
    
    private var disposeBag = DisposeBag()

    private let task = "TaskTVC"
    
    private var clients: [Client] = ClientsViewModel.shared.getClients().filter { !$0.projects.isEmpty}
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.delegate = self
        self.dataSource = self
        
        separatorStyle = .none
        showsVerticalScrollIndicator = false
        backgroundColor = .clear
        
        self.register(TaskTVC.self, forCellReuseIdentifier: task)
        
        ClientsViewModel.shared.observeClients().subscribe(onNext: { event in
            self.clients = ClientsViewModel.shared.getClients().filter { !$0.projects.isEmpty}
            self.reloadData()
        }).disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension TasksByClientTV: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = DS.Colors.mainViewColor
        
        let label = UILabel()
        label.text = clients[section].name
        label.textColor = DS.Colors.standartTextColor
        label.font = UIFont(name: "Manrope-Bold", size: 100)
        label.adjustsFontSizeToFitWidth = true
        headerView.addSubview(label)
        
        label.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(DS.Constraints.baseInsetViews)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
            $0.height.equalTo(headerView.snp.width).multipliedBy(DS.SizeMultipliers.tenPercent)
        }
        return headerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return clients.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var tasks: [Task] = []
        clients[section].projects.forEach { project in
            project.tasks.forEach { tasks.append($0) }
        }
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let taskCell = tableView.dequeueReusableCell(withIdentifier: "TaskTVC") as? TaskTVC else {
            return UITableViewCell()
        }
        
        if clients.isEmpty {
            taskCell.emptyTasksList()
        } else {
            var tasks: [Task] = []
            clients[indexPath.section].projects.forEach { project in
                project.tasks.forEach { tasks.append($0) }
            }
            let task = tasks.sorted {!$0.status && $1.status}[indexPath.row]
            taskCell.addTask(title: task.desc, completionStatus: task.status)
            taskCell.selectionStyle = .none
        }
        return taskCell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard !clients.isEmpty else { return UISwipeActionsConfiguration() }
        let swipe = UIContextualAction(style: .destructive, title: "Не виконано") { (action, view, success) in
            var tasks: [Task] = []
            self.clients[indexPath.section].projects.forEach { project in
                project.tasks.forEach { tasks.append($0) }
            }
            TasksViewModel.shared.updateTaskStatus(with: tasks[indexPath.row], status: false)
            success(true)
        }
        return UISwipeActionsConfiguration(actions: [swipe])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard !clients.isEmpty else { return UISwipeActionsConfiguration() }
        let swipe = UIContextualAction(style: .normal, title: "Виконано") { (action, view, success) in
            var tasks: [Task] = []
            self.clients[indexPath.section].projects.forEach { project in
                project.tasks.forEach { tasks.append($0) }
            }
            TasksViewModel.shared.updateTaskStatus(with: tasks[indexPath.row], status: true)
            success(true)
        }
        swipe.backgroundColor = DS.Colors.taskFinished
        
        return UISwipeActionsConfiguration(actions: [swipe])
    }
}

