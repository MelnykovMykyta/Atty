//
//  ClientInfoTV.swift
//  Atty
//
//  Created by Nikita Melnikov on 09.11.2023.
//

import Foundation
import UIKit
import SnapKit
import RxCocoa
import RxSwift

class ClientInfoTV: UITableView {
    
    private var disposeBag = DisposeBag()
    
    let client = "ClientTVC"
    let header = "HeaderTVC"
    let task = "TaskTVC"
    
    private var clientItem: Client = ClientsViewModel.currentClient
    private var clientTasks = ClientsViewModel.shared.getClientProjectsTasks()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.delegate = self
        self.dataSource = self
        
        separatorStyle = .none
        showsVerticalScrollIndicator = false
        backgroundColor = .clear
        
        self.register(ClientTVC.self, forCellReuseIdentifier: client)
        self.register(HeaderTVC.self, forCellReuseIdentifier: header)
        self.register(TaskTVC.self, forCellReuseIdentifier: task)
        
        ClientsViewModel.shared.observeClients().subscribe(onNext: { event in
            self.clientItem = ClientsViewModel.currentClient
            self.clientTasks = ClientsViewModel.shared.getClientProjectsTasks()
            self.reloadData()
        }).disposed(by: disposeBag)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension ClientInfoTV: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return clientTasks.isEmpty ? 1 : clientTasks.count
        case 3:
            return 1
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let clientCell = tableView.dequeueReusableCell(withIdentifier: "ClientTVC") as? ClientTVC,
              let clientHeaderCell = tableView.dequeueReusableCell(withIdentifier: "HeaderTVC") as? HeaderTVC,
              let tasksCell = tableView.dequeueReusableCell(withIdentifier: "TaskTVC") as? TaskTVC
        else { return UITableViewCell() }
        
        switch indexPath.section {
        case 0:
            clientCell.addFullClient(clientName: clientItem.name, contactPerson: clientItem.contactPerson, contact: clientItem.contact, email: clientItem.email, idCode: clientItem.idCode)
            clientCell.selectionStyle = .none
            return clientCell
        case 1:
            clientHeaderCell.addTitle(title: "Задачі")
            clientHeaderCell.selectionStyle = .none
            return clientHeaderCell
        case 2:
            if clientTasks.isEmpty {
                tasksCell.emptyTasksList()
            } else {
                
                tasksCell.addTask(title: clientTasks[indexPath.row].desc, completionStatus: clientTasks[indexPath.row].status)
            }
            tasksCell.selectionStyle = .none
            return tasksCell
        case 3:
            clientHeaderCell.addTitle(title: "Суди")
            return clientHeaderCell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return swipe(indexPath: indexPath, status: false)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return swipe(indexPath: indexPath, status: true)
    }
}

extension ClientInfoTV {
    private func swipe(indexPath: IndexPath, status: Bool) -> UISwipeActionsConfiguration {
        guard indexPath.section == 2 && !clientTasks.isEmpty else {  return UISwipeActionsConfiguration() }
        let title = status ? "Виконано" : "Не виконано"
        let style: UIContextualAction.Style = status ? .normal : .destructive
        
        let swipe = UIContextualAction(style: style, title: title) { (action, view, success) in
            let task = self.clientTasks[indexPath.row]
            TasksViewModel.shared.updateTaskStatus(with: task, status: status)
            success(true)
        }
        if status { swipe.backgroundColor = DS.Colors.taskFinished }
        
        return UISwipeActionsConfiguration(actions: [swipe])
    }
}
