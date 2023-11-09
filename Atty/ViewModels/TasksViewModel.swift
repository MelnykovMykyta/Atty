//
//  TasksViewModel.swift
//  Atty
//
//  Created by Nikita Melnikov on 05.11.2023.
//

import Foundation
import RealmSwift
import RxRealm
import RxCocoa
import RxSwift

class TasksViewModel {
    
    static let shared = TasksViewModel()
    
    let realm = try! Realm()
    
    func observeTasks() -> Observable<[Task]> {
        return Observable.collection(from: realm.objects(Task.self))
            .map { results in
                return results
                    .toArray()
                    .sorted { $0.date < $1.date }
                    .sorted { !$0.status && $1.status}
            }
    }
    
    func addTask(with task: Task) {
        RealmDBService.shared.addObject(object: task)
    }
    
    func getTasks() -> [Task] {
        return RealmDBService.shared.getObjects(Task.self).sorted { !$0.status && $1.status}
    }
    
    func updateTaskStatus(with task: Task, status: Bool) {
        RealmDBService.shared.updateTaskStatus(with: task, status: status)
    }
}
