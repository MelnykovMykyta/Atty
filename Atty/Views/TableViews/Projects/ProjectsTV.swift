//
//  ProjectsTV.swift
//  Atty
//
//  Created by Nikita Melnikov on 07.11.2023.
//

import Foundation
import UIKit
import SnapKit
import RxCocoa
import RxSwift

class ProjectsTV: UITableView {
    
    private var disposeBag = DisposeBag()
    
    let project = "ProjectTVC"
    
//    private var tasks: [Task] = TasksViewModel.shared.getTasks().filter {$0.status == false }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
//        TasksViewModel.shared.observeTasks().subscribe(onNext: { event in
//            self.tasks = TasksViewModel.shared.getTasks().filter {$0.status == false }
//            self.reloadData()
//        }).disposed(by: disposeBag)
        
        
        self.delegate = self
        self.dataSource = self
        
        separatorStyle = .none
        allowsSelection = false
        showsVerticalScrollIndicator = false
        backgroundColor = .clear
        
        self.register(ProjectTVC.self, forCellReuseIdentifier: project)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProjectsTV: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        tasks.isEmpty ? 1 : tasks.count
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let projectCell = tableView.dequeueReusableCell(withIdentifier: "ProjectTVC") as? ProjectTVC else {
            return UITableViewCell()
        }

//            if tasks.isEmpty {
        projectCell.emptyProjectsList()
//            } else {
//        projectCell.addProject(projectName: "Спір про право власності (земля Ворзель)", clientName: "Кожух А. Т.", category: "Адміністративне", completionStatus: false)
//            }
            return projectCell
    }
    
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        if !tasks.isEmpty {
//            let swipe = UIContextualAction(style: .destructive, title: "Не завершено") { (action, view, success) in
//                let task = self.tasks[indexPath.row]
//                TasksViewModel.shared.updateTaskStatus(with: task, status: false)
//                success(true)
//            }
//            return UISwipeActionsConfiguration(actions: [swipe])
//        }
//        return UISwipeActionsConfiguration()
//    }
//    
//    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        
//        if !tasks.isEmpty {
//            let swipe = UIContextualAction(style: .normal, title: "Виконано") { (action, view, success) in
//                let task = self.tasks[indexPath.row]
//                TasksViewModel.shared.updateTaskStatus(with: task, status: true)
//                success(true)
//            }
//            swipe.backgroundColor = DS.Colors.taskFinished
//            
//            return UISwipeActionsConfiguration(actions: [swipe])
//        }
//        return UISwipeActionsConfiguration()
//    }
}


