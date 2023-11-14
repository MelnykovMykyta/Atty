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
    
    private let client = "ClientTVC"
    private let header = "HeaderTVC"
    private let task = "TaskTVC"
    private let meet = "CourtMeetTVC"
    
    private var clientItem: Client = ClientsViewModel.currentClient
    private var clientTasks = ClientsViewModel.getClientProjectsTasks()
    private var clientCourts: [CourtCase] = ClientsViewModel.getClientCourts()
    
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
        self.register(CourtMeetTVC.self, forCellReuseIdentifier: meet)
        
        ClientsViewModel.observeClients().subscribe(onNext: { event in
            self.clientItem = ClientsViewModel.currentClient
            self.clientTasks = ClientsViewModel.getClientProjectsTasks()
            self.reloadData()
        }).disposed(by: disposeBag)
        
        CourtsViewModel.observeCases().subscribe(onNext: { event in
            self.clientCourts = ClientsViewModel.getClientCourts()
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
        case 4:
            return clientCourts.isEmpty ? 1 : clientCourts.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let clientCell = tableView.dequeueReusableCell(withIdentifier: "ClientTVC") as? ClientTVC,
              let clientHeaderCell = tableView.dequeueReusableCell(withIdentifier: "HeaderTVC") as? HeaderTVC,
              let tasksCell = tableView.dequeueReusableCell(withIdentifier: "TaskTVC") as? TaskTVC,
              let meetCell = tableView.dequeueReusableCell(withIdentifier: "CourtMeetTVC") as? CourtMeetTVC
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
            clientHeaderCell.selectionStyle = .none
            return clientHeaderCell
            
        case 4:
            if clientCourts.isEmpty {
                meetCell.emptyCourtMeetsList(with: "По клієнту справи не відстежуються")
            } else {
                let caseItem = clientCourts[indexPath.row]
                meetCell.addCourtCase(courtName: caseItem.courtName, caseNumber: caseItem.caseNumber, plaintiff: caseItem.plaintiff, defendant: caseItem.defendant, judge: caseItem.judge, status: caseItem.status)
            }
            meetCell.selectionStyle = .none
            return meetCell
            
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
        
        let swipe = UIContextualAction(style: .destructive, title: title) { (action, view, success) in
            let task = self.clientTasks[indexPath.row]
            TasksViewModel.updateTaskStatus(with: task, status: status)
            success(true)
        }
        if status { swipe.backgroundColor = DS.Colors.taskFinished }
        
        return UISwipeActionsConfiguration(actions: [swipe])
    }
}
