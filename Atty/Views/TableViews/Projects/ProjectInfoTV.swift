//
//  ProjectInfoTV.swift
//  Atty
//
//  Created by Nikita Melnikov on 07.11.2023.
//

import Foundation
import UIKit
import SnapKit
import RxCocoa
import RxSwift

class ProjectInfoTV: UITableView {

    private var disposeBag = DisposeBag()

    let project = "ProjectTVC"
    let header = "HeaderTVC"
    let task = "TaskTVC"

    private var projectItem: Project = ProjectsViewModel.currentProject

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)

        self.delegate = self
        self.dataSource = self

        separatorStyle = .none
        showsVerticalScrollIndicator = false
        backgroundColor = .clear

        self.register(ProjectTVC.self, forCellReuseIdentifier: project)
        self.register(HeaderTVC.self, forCellReuseIdentifier: header)
        self.register(TaskTVC.self, forCellReuseIdentifier: task)

        ProjectsViewModel.shared.observeProjects().subscribe(onNext: { event in
            self.projectItem = ProjectsViewModel.currentProject
            self.reloadData()
        }).disposed(by: disposeBag)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProjectInfoTV: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return projectItem.tasks.isEmpty ? 1 : projectItem.tasks.count
        default:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let projectCell = tableView.dequeueReusableCell(withIdentifier: "ProjectTVC") as? ProjectTVC,
              let projectHeaderCell = tableView.dequeueReusableCell(withIdentifier: "HeaderTVC") as? HeaderTVC,
              let tasksCell = tableView.dequeueReusableCell(withIdentifier: "TaskTVC") as? TaskTVC
        else { return UITableViewCell() }

        switch indexPath.section {
        case 0:
            projectCell.addFullProject(projectName: projectItem.name, clientName: "", category: projectItem.category, shortDesc: projectItem.shortDesc, additionalDesc: projectItem.additionalDesc)
            projectCell.selectionStyle = .none
            return projectCell
        case 1:
            projectHeaderCell.addTitle(title: "Задачі")
            projectHeaderCell.selectionStyle = .none
            return projectHeaderCell
        case 2:
            if projectItem.tasks.isEmpty {
                tasksCell.emptyTasksList()
            } else {
                tasksCell.addTask(title: projectItem.tasks[indexPath.row].desc, completionStatus: projectItem.tasks[indexPath.row].status)
            }
            tasksCell.selectionStyle = .none
            return tasksCell
        default:
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard indexPath.section == 2 && !projectItem.tasks.isEmpty else {  return UISwipeActionsConfiguration() }
        let swipe = UIContextualAction(style: .destructive, title: "Не виконано") { (action, view, success) in
                let task = self.projectItem.tasks[indexPath.row]
                TasksViewModel.shared.updateTaskStatus(with: task, status: false)
                success(true)
            }
            return UISwipeActionsConfiguration(actions: [swipe])
    }

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard indexPath.section == 2 && !projectItem.tasks.isEmpty else {  return UISwipeActionsConfiguration() }
            let swipe = UIContextualAction(style: .normal, title: "Виконано") { (action, view, success) in
                let task = self.projectItem.tasks[indexPath.row]
                TasksViewModel.shared.updateTaskStatus(with: task, status: true)
                success(true)
            }
            swipe.backgroundColor = DS.Colors.taskFinished

            return UISwipeActionsConfiguration(actions: [swipe])
    }
}

