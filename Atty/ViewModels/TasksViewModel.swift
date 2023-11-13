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
    
    static let realm = try! Realm()
    
    static func observeTasks() -> Observable<[Task]> {
        return Observable.collection(from: realm.objects(Task.self))
            .map { results in
                return results
                    .toArray()
                    .filter { $0.user == AuthViewModel.getCurrentUser() }
                    .sorted { $0.date < $1.date }
                    .sorted { !$0.status && $1.status}
            }
    }
    
    static func observeDeadlineTasks() -> Observable<[Task]> {
        return Observable.collection(from: realm.objects(Task.self))
            .map { results in
                return results
                    .toArray()
                    .filter { $0.user == AuthViewModel.getCurrentUser() }
                    .filter { $0.deadline != nil }
                    .filter { DateHelper.compareDates(date: $0.deadline ?? Date()) }
            }
    }
    
    static func addTask(with task: Task) {
        RealmDBService.addObject(object: task)
    }
    
    static func getTasks() -> [Task] {
        return RealmDBService.getObjects(Task.self)
            .filter {$0.user == AuthViewModel.getCurrentUser() }
            .sorted { !$0.status && $1.status}
    }
    
    static func getTasksWithTodayDeadline() -> [Task] {
        return RealmDBService.getObjects(Task.self)
            .filter {$0.user == AuthViewModel.getCurrentUser() }
            .filter { $0.deadline != nil }
            .filter { DateHelper.compareDates(date: $0.deadline ?? Date()) }
            .sorted { !$0.status && $1.status}
    }
    
    static func updateTaskStatus(with task: Task, status: Bool) {
        RealmDBService.updateTaskStatus(with: task, status: status)
    }
}
