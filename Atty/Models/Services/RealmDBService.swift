//
//  RealmDBService.swift
//  Atty
//
//  Created by Nikita Melnikov on 05.11.2023.
//

import Foundation
import RealmSwift

class RealmDBService {
    
    static let shared = RealmDBService()
    
    let realm = try! Realm()
    
    private init() {}
    
    func addTask(with task: Task) {
        try! realm.write {
            realm.add(task, update: .modified)
        }
    }
    
    func addDefaults() {
        let task1 = Task(desc: "Забрати документи", status: false)
        let task2 = Task(desc: "Віддати аванс та розрахуватись за експертизу", status: true)
        let task3 = Task(desc: "Скласти позовну заяву", status: false)
        let task4 = Task(desc: "Поспілкуватись з державним виконавцем", status: true)
        [task1, task2, task3, task4].forEach ({ task in
            
            try! realm.write {
                realm.add(task.self, update: .modified)
            }
        })
    }
    
    func getTasks() -> [Task] {
        let tasks = realm.objects(Task.self)
        return Array(tasks.sorted { !$0.status && $1.status})
    }
    
    func updateTaskStatus(with task: Task, status: Bool) {
        try! realm.write {
            if let taskToUpdate = realm.objects(Task.self).filter("desc == %@", task.desc).first {
                taskToUpdate.status = status
            }
        }
    }
}
