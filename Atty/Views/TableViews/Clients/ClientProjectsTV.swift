//
//  ClientProjectsTV.swift
//  Atty
//
//  Created by Nikita Melnikov on 11.11.2023.
//

import Foundation
import UIKit
import SnapKit
import RxCocoa
import RxSwift

class ClientProjectsTV: UITableView {
    
    private var disposeBag = DisposeBag()
    
    private let project = "ProjectTVC"
    
    private var projects: [Project] = ClientsViewModel.getClientProjects().sorted { !$0.status && $1.status}
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.delegate = self
        self.dataSource = self
        
        separatorStyle = .none
        showsVerticalScrollIndicator = false
        backgroundColor = .clear
        
        self.register(ProjectTVC.self, forCellReuseIdentifier: project)
        
        ProjectsViewModel.observeProjects().subscribe(onNext: { event in
            self.projects = ClientsViewModel.getClientProjects().sorted { !$0.status && $1.status}
            self.reloadData()
        }).disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension ClientProjectsTV: UITableViewDelegate, UITableViewDataSource {
    
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
        
        let project = self.projects[indexPath.row]
        
        if !projects.isEmpty && !project.status {
            let swipe = UIContextualAction(style: .destructive, title: "В архів") { (action, view, success) in
                ProjectsViewModel.updateProjectStatus(with: project, status: true)
                success(true)
            }
            return UISwipeActionsConfiguration(actions: [swipe])
        }
        return UISwipeActionsConfiguration()
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let project = self.projects[indexPath.row]
        
        if !projects.isEmpty && project.status {
            let swipe = UIContextualAction(style: .destructive, title: "Виконано") { (action, view, success) in
                
                ProjectsViewModel.updateProjectStatus(with: project, status: false)
                success(true)
            }
            swipe.backgroundColor = DS.Colors.taskFinished
            
            return UISwipeActionsConfiguration(actions: [swipe])
        }
        return UISwipeActionsConfiguration()
    }
}
