//
//  DoneTasksTV.swift
//  Atty
//
//  Created by Nikita Melnikov on 07.11.2023.
//

import Foundation
import UIKit
import SnapKit
import RxCocoa
import RxSwift

class DoneTasksTV: UITableView {
    
    private var disposeBag = DisposeBag()
    
    let task = "TaskTVC"
    
    private var tasks: [Task] = TasksViewModel.shared.getTasks().filter {$0.status == true }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        TasksViewModel.shared.observeTasks().subscribe(onNext: { event in
            self.tasks = TasksViewModel.shared.getTasks().filter {$0.status == true }
            self.reloadData()
        }).disposed(by: disposeBag)
        
        
        self.delegate = self
        self.dataSource = self
        
        separatorStyle = .none
        allowsSelection = false
        showsVerticalScrollIndicator = false
        backgroundColor = .clear
        
        self.register(TaskTVC.self, forCellReuseIdentifier: task)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DoneTasksTV: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.isEmpty ? 1 : tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tasksCell = tableView.dequeueReusableCell(withIdentifier: "TaskTVC") as? TaskTVC else {
            return UITableViewCell()
        }

            if tasks.isEmpty {
                tasksCell.emptyTasksList()
            } else {
                tasksCell.addTask(title: tasks[indexPath.row].desc, completionStatus: tasks[indexPath.row].status)
            }
            return tasksCell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if !tasks.isEmpty {
            let swipe = UIContextualAction(style: .destructive, title: "Не виконано") { (action, view, success) in
                let task = self.tasks[indexPath.row]
                TasksViewModel.shared.updateTaskStatus(with: task, status: false)
                success(true)
            }
            return UISwipeActionsConfiguration(actions: [swipe])
        }
        return UISwipeActionsConfiguration()
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        if !tasks.isEmpty {
            let swipe = UIContextualAction(style: .normal, title: "Виконано") { (action, view, success) in
                let task = self.tasks[indexPath.row]
                TasksViewModel.shared.updateTaskStatus(with: task, status: true)
                success(true)
            }
            swipe.backgroundColor = DS.Colors.taskFinished
            
            return UISwipeActionsConfiguration(actions: [swipe])
        }
        return UISwipeActionsConfiguration()
    }
}
