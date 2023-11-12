//
//  ClientsTV.swift
//  Atty
//
//  Created by Nikita Melnikov on 09.11.2023.
//

import Foundation
import UIKit
import SnapKit
import RxCocoa
import RxSwift

protocol ClientsTVDelegate {
    func didSelectClient(_ client: Client)
}

class ClientsTV: UITableView {
    
    private var disposeBag = DisposeBag()
    
    var delegateClient: ClientsTVDelegate?
    
    private let client = "ClientTVC"
    
    private var clients: [Client] = ClientsViewModel.shared.getClients().filter { $0.status == false }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.delegate = self
        self.dataSource = self
        
        separatorStyle = .none
        showsVerticalScrollIndicator = false
        backgroundColor = .clear
        
        self.register(ClientTVC.self, forCellReuseIdentifier: client)
        
        ClientsViewModel.shared.observeClients().subscribe(onNext: { event in
            self.clients = ClientsViewModel.shared.getClients().filter { $0.status == false }
            self.reloadData()
        }).disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension ClientsTV: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        clients.isEmpty ? 1 : clients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let clientCell = tableView.dequeueReusableCell(withIdentifier: "ClientTVC") as? ClientTVC else {
            return UITableViewCell()
        }
        
        if clients.isEmpty {
            clientCell.emptyClientsList()
        } else {
            let client = clients[indexPath.row]
            clientCell.addClient(clientName: client.name, contact: client.contact, projects: client.projects.count.description, completionStatus: client.status)
            clientCell.selectionStyle = .none
        }
        return clientCell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let client = self.clients[indexPath.row]
        
        if !clients.isEmpty && client.status {
            let swipe = UIContextualAction(style: .destructive, title: "Не завершено") { (action, view, success) in
                ClientsViewModel.shared.updateClientStatus(with: client, status: false)
                success(true)
            }
            return UISwipeActionsConfiguration(actions: [swipe])
        }
        return UISwipeActionsConfiguration()
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let client = self.clients[indexPath.row]
        
        if !clients.isEmpty && !client.status {
            let swipe = UIContextualAction(style: .destructive, title: "Виконано") { (action, view, success) in
                ClientsViewModel.shared.updateClientStatus(with: client, status: true)
                success(true)
            }
            swipe.backgroundColor = DS.Colors.taskFinished
            
            return UISwipeActionsConfiguration(actions: [swipe])
        }
        return UISwipeActionsConfiguration()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !clients.isEmpty {
            let selectedClient = clients[indexPath.row]
            delegateClient?.didSelectClient(selectedClient)
            
            ClientsViewModel.currentClient = selectedClient
        }
    }
}

