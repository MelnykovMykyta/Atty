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

protocol ProjectsTVDelegate {
    func didSelectProject(_ project: Project)
}

class ProjectsTV: UITableView {
    
    private var disposeBag = DisposeBag()
    
    var delegateProject: ProjectsTVDelegate?
    
    private let project = "ProjectTVC"
    
    private var projects: [Project] = ProjectsViewModel.shared.getProjects().filter { $0.status == false }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.delegate = self
        self.dataSource = self
        
        separatorStyle = .none
        showsVerticalScrollIndicator = false
        backgroundColor = .clear
        
        self.register(ProjectTVC.self, forCellReuseIdentifier: project)
        
        ProjectsViewModel.shared.observeProjects().subscribe(onNext: { event in
            self.projects = ProjectsViewModel.shared.getProjects().filter { $0.status == false }
            self.reloadData()
        }).disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension ProjectsTV: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        projects.isEmpty ? 1 : projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let projectCell = tableView.dequeueReusableCell(withIdentifier: "ProjectTVC") as? ProjectTVC else {
            return UITableViewCell()
        }
        
        if projects.isEmpty {
            projectCell.emptyProjectsList()
        } else {
            projectCell.addProject(projectName: projects[indexPath.row].name, clientName: projects[indexPath.row].client?.name ?? "", category: projects[indexPath.row].category, completionStatus: projects[indexPath.row].status)
            projectCell.selectionStyle = .none
        }
        return projectCell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if !projects.isEmpty {
            let swipe = UIContextualAction(style: .destructive, title: "Не завершено") { (action, view, success) in
                let project = self.projects[indexPath.row]
                ProjectsViewModel.shared.updateProjectStatus(with: project, status: false)
                success(true)
            }
            return UISwipeActionsConfiguration(actions: [swipe])
        }
        return UISwipeActionsConfiguration()
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        if !projects.isEmpty {
            let swipe = UIContextualAction(style: .normal, title: "Виконано") { (action, view, success) in
                let project = self.projects[indexPath.row]
                ProjectsViewModel.shared.updateProjectStatus(with: project, status: true)
                success(true)
            }
            swipe.backgroundColor = DS.Colors.taskFinished
            
            return UISwipeActionsConfiguration(actions: [swipe])
        }
        return UISwipeActionsConfiguration()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !projects.isEmpty {
            let selectedProject = projects[indexPath.row]
            delegateProject?.didSelectProject(selectedProject)
            
            ProjectsViewModel.currentProject = selectedProject
        }
    }
}
