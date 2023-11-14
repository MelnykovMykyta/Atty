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
    
    static let realm = try! Realm()
    
    static func addObject<T: Object>(object: T) {
        try! realm.write {
            realm.add(object, update: .modified)
        }
    }
    
    static func getObjects<T: Object>(_ objectType: T.Type) -> [T] {
        let objects = realm.objects(objectType)
        return Array(objects)
    }
    
    static func updateTaskStatus(with task: Task, status: Bool) {
        try! realm.write {
            guard let task_ = realm.objects(Task.self).filter("id == %@", task.id).first else { return }
            task_.status = status
        }
    }
    
    static func updateProjectStatus(with project: Project, status: Bool) {
        try! realm.write {
            guard let project_ = realm.objects(Project.self).filter("id == %@", project.id).first else { return }
            project_.status = status
        }
    }
    
    static func updateClientStatus(with client: Client, status: Bool) {
        try! realm.write {
            guard let client_ = realm.objects(Client.self).filter("id == %@", client.id).first else { return }
            client_.status = status
        }
    }
    
    static func updateCourtCaseStatus(with courtCase: CourtCase, status: Bool) {
        try! realm.write {
            guard let courtCase_ = realm.objects(CourtCase.self).filter("id == %@", courtCase.id).first else { return }
            courtCase_.status = status
        }
    }
    
    static func addTaskToProject(_ task: Task, to project: Project) {
        try! realm.write {
            project.tasks.append(task)
        }
    }
    
    static func addProjectToClient(_ project: Project, to client: Client) {
        try! realm.write {
            client.projects.append(project)
            project.client = client
        }
    }
    
    static func addCourtCaseToProject(_ courtCase: CourtCase, to project: Project) {
        try! realm.write {
            project.courtCases.append(courtCase)
            courtCase.project = project
            courtCase.client = project.client
        }
    }
    
    static func addCourtCaseToUser(_ courtCase: String, to user: User) {
        try! realm.write {
            user.courtCases.append(courtCase)
        }
    }
}

