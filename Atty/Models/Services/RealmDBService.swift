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
            if let taskToUpdate = realm.objects(Task.self).filter("id == %@", task.id).first {
                taskToUpdate.status = status
            }
        }
    }
}
