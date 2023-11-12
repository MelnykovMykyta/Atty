//
//  RealmDBService.swift
//  Atty
//
//  Created by Nikita Melnikov on 05.11.2023.
//

import Foundation
import RealmSwift
import RxRealm
import RxCocoa
import RxSwift

class RealmDBService {
    
    static let shared = RealmDBService()
    
    let realm = try! Realm()
    
    func addObject<T: Object>(object: T) {
        try! realm.write {
            realm.add(object, update: .modified)
        }
    }
    
    func getObjects<T: Object>(_ objectType: T.Type) -> [T] {
        let objects = realm.objects(objectType)
        return Array(objects)
    }
    
    func updateTaskStatus(with task: Task, status: Bool) {
        try! realm.write {
            guard let task_ = realm.objects(Task.self).filter("id == %@", task.id).first else { return }
            task_.status = status
        }
    }
    
    func updateProjectStatus(with project: Project, status: Bool) {
        try! realm.write {
            guard let project_ = realm.objects(Project.self).filter("id == %@", project.id).first else { return }
            project_.status = status
        }
    }
    
    func updateClientStatus(with client: Client, status: Bool) {
        try! realm.write {
            guard let client_ = realm.objects(Client.self).filter("id == %@", client.id).first else { return }
            client_.status = status
        }
    }
    
    func updateCourtCaseStatus(with courtCase: CourtCase, status: Bool) {
        try! realm.write {
            guard let courtCase_ = realm.objects(CourtCase.self).filter("id == %@", courtCase.id).first else { return }
            courtCase_.status = status
        }
    }
    
    func addTaskToProject(_ task: Task, to project: Project) {
        try! realm.write {
            project.tasks.append(task)
        }
    }
    
    func addProjectToClient(_ project: Project, to client: Client) {
        try! realm.write {
            client.projects.append(project)
            project.client = client
        }
    }
    
    func addCourtCseToProject(_ courtCase: CourtCase, to project: Project) {
        try! realm.write {
            project.courtCases.append(courtCase)
            courtCase.project = project
            courtCase.client = project.client
        }
    }
}
