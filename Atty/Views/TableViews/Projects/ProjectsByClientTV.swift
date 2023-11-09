//
//  ProjectsByClientTV.swift
//  Atty
//
//  Created by Nikita Melnikov on 09.11.2023.
//

import Foundation
import UIKit
import SnapKit
import RxCocoa
import RxSwift

class ProjectsByClientTV: UITableView {
    
    private var disposeBag = DisposeBag()
    
    var delegateProject: ProjectsTVDelegate?
    
    private let project = "ProjectTVC"
    
    private var clients: [Client] = ClientsViewModel.shared.getClients().filter { !$0.projects.isEmpty}
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.delegate = self
        self.dataSource = self
        
        separatorStyle = .none
        showsVerticalScrollIndicator = false
        backgroundColor = .clear
        
        self.register(ProjectTVC.self, forCellReuseIdentifier: project)
        
        ClientsViewModel.shared.observeClients().subscribe(onNext: { event in
            self.clients = ClientsViewModel.shared.getClients().filter { !$0.projects.isEmpty}
            self.reloadData()
        }).disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension ProjectsByClientTV: UITableViewDelegate, UITableViewDataSource {
    
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
        return clients[section].projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let projectCell = tableView.dequeueReusableCell(withIdentifier: "ProjectTVC") as? ProjectTVC else {
            return UITableViewCell()
        }
        
        if clients.isEmpty {
            projectCell.emptyProjectsList()
        } else {
            
            let project = clients[indexPath.section].projects.sorted {!$0.status && $1.status}[indexPath.row]
            projectCell.addProject(projectName: project.name, clientName: project.client?.name ?? "", category: project.category, completionStatus: project.status)
            projectCell.selectionStyle = .none
        }
        return projectCell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if !clients.isEmpty {
            let project = self.clients[indexPath.section].projects.sorted {!$0.status && $1.status}[indexPath.row]
            let swipe = UIContextualAction(style: .destructive, title: "Не завершено") { (action, view, success) in
                ProjectsViewModel.shared.updateProjectStatus(with: project, status: false)
                success(true)
            }
            return UISwipeActionsConfiguration(actions: [swipe])
        }
        return UISwipeActionsConfiguration()
    }

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        if !clients.isEmpty {
            let swipe = UIContextualAction(style: .normal, title: "Виконано") { (action, view, success) in
                let project = self.clients[indexPath.section].projects.sorted {!$0.status && $1.status}[indexPath.row]
                ProjectsViewModel.shared.updateProjectStatus(with: project, status: true)
                success(true)
            }
            swipe.backgroundColor = DS.Colors.taskFinished

            return UISwipeActionsConfiguration(actions: [swipe])
        }
        return UISwipeActionsConfiguration()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !clients.isEmpty {
            let selectedProject = clients[indexPath.section].projects[indexPath.row]
            delegateProject?.didSelectProject(selectedProject)
            
            ProjectsViewModel.currentProject = selectedProject
        }
    }
}
