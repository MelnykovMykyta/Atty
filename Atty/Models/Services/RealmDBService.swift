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
    
    private init() {}
    
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
    
    func addTaskToProject(_ task: Task, to project: Project) {
        try! realm.write {
            project.tasks.append(task)
        }
    }
    
    func addPro(){
        let project1 = Project(name: "Project 1", shortDesc: "Short description for Project 1", additionalDesc: "Additional description for Project 1", status: true, category: "Category1")

        let project2 = Project(name: "Project 2", shortDesc: "Short description for Project 2", additionalDesc: "Additional description for Project 2", status: false, category: "Category2")

        let project3 = Project(name: "Project 3", shortDesc: "Short description for Project 3", additionalDesc: "Additional description for Project 3", status: true, category: "Category3")

        let project4 = Project(name: "Project 4", shortDesc: "Short description for Project 4", additionalDesc: "Additional description for Project 4", status: false, category: "Category4")

        let project5 = Project(name: "Project 5", shortDesc: "Short description for Project 5", additionalDesc: "Additional description for Project 5", status: true, category: "Category5")
        
        [project1, project2, project3, project4, project5].forEach { pro in
            addObject(object: pro)
        }
    }
}
