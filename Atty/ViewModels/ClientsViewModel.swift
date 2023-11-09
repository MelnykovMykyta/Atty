//
//  ClientsViewModel.swift
//  Atty
//
//  Created by Nikita Melnikov on 09.11.2023.
//

import Foundation
import RealmSwift
import RxRealm
import RxCocoa
import RxSwift

class ClientsViewModel {
    
    static let shared = ClientsViewModel()
    
    static var currentClient: Client = Client()
    
    let realm = try! Realm()
    
    func observeClients() -> Observable<[Client]> {
        return Observable.collection(from: realm.objects(Client.self))
            .map { results in
                return results.toArray()
            }
    }
    
    func addClient(with client: Client) {
        RealmDBService.shared.addObject(object: client)
    }
    
    func getClients() -> [Client] {
        return RealmDBService.shared.getObjects(Client.self).sorted { !$0.status && $1.status}
    }
    
    func getClientProjectsTasks() -> [Task] {
        let tasks: [Task] = ClientsViewModel.currentClient.projects.flatMap { $0.tasks }
        let sortedClientTasks: [Task] = tasks.sorted { $0.date < $1.date }
            .sorted { !$0.status && $1.status}
        return sortedClientTasks
    }
    
    func updateClientStatus(with client: Client, status: Bool) {
        RealmDBService.shared.updateClientStatus(with: client, status: status)
    }
}
