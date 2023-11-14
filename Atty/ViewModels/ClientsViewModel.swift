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
    
    static let realm = try! Realm()
    
    static var currentClient: Client = Client()
    
    static func observeClients() -> Observable<[Client]> {
        return Observable.collection(from: realm.objects(Client.self))
            .map { results in
                return results.toArray()
                    .filter { $0.user == AuthViewModel.getCurrentUser() }
            }
    }
    
    static func addClient(with client: Client) {
        RealmDBService.addObject(object: client)
    }
    
    static func getClients() -> [Client] {
        return RealmDBService.getObjects(Client.self)
            .filter { $0.user == AuthViewModel.getCurrentUser() }
            .sorted { !$0.status && $1.status}
    }
    
    static func getClientProjectsTasks() -> [Task] {
        let tasks: [Task] = ClientsViewModel.currentClient.projects.flatMap { $0.tasks }
        let sortedClientTasks: [Task] = tasks.sorted { $0.date < $1.date }
            .sorted { !$0.status && $1.status}
        return sortedClientTasks
    }
    
    static func getClientCourts() -> [CourtCase] {
        let cases: [CourtCase] = CourtsViewModel.getCourtCases()
            .filter { $0.client == ClientsViewModel.currentClient }
            .sorted { !$0.status && $1.status}
        return cases
    }
    
    static func updateClientStatus(with client: Client, status: Bool) {
        RealmDBService.updateClientStatus(with: client, status: status)
    }
    
    static func getClientProjects() -> [Project] {
        return RealmDBService.getObjects(Project.self)
            .filter { $0.user == AuthViewModel.getCurrentUser() }
            .filter { $0.client == currentClient}
    }
}
