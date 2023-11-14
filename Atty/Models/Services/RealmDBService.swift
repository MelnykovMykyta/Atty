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
    
    
    static func addMockDate() {
        guard let user = AuthViewModel.getCurrentUser() else { return }
        let tasks: [Task] = [Task(desc: "Скласти позовну заяву", user: user),
                             Task(desc: "Направити позовну заяву до Хмельницького суду", user: user),
                             Task(desc: "Пройти курс тематичного удосконалення", deadline: Date(), user: user),
                             Task(desc: "Підготувати письмову відповідь від Пилипенко", deadline: Date(), user: user),
                             Task(desc: "Провести аналіз судової практики", user: user),
                             Task(desc: "Зустрітись з державним виконавцем", deadline: Date(), user: user),
                             Task(desc: "Провести переговори з відповідачем по землі в Гостомелі", deadline: Date(), user: user)]
        
        let projects: [Project] = [Project(name: "Розбій", shortDesc: "Обвинувачений Ватан Б. О.", additionalDesc: "Розбійний напад клієнта. Каже підстава. Треба розібратись. Свідки відсутні, але є відео", category: "Кримінал", user: user),
                                   Project(name: "Земля Ірпінь", shortDesc: "Витребувати", additionalDesc: "Витребування з незаконного володіння. Зараз користується Жваронок Андрій", category: "Цивільне", user: user),
                                   Project(name: "Штраф ДТП", shortDesc: "Оскарження", additionalDesc: "Мій штраф, не порушував, є відеореєстратор, подача позовної заяви", category: "Адміністративне", user: user)]
        
        let cliens: [Client] = [Client(name: "Войтенко О. О.", contactPerson: "Войтенко О. О.", contact: "066-111-11-22", email: "poovar@ukr.net", idCode: "", user: user),
                                Client(name: "ТОВ НАНО", contactPerson: "Рогов Андрій", contact: "098-222-33-22", email: "tovnano@ukr.net", idCode: "39382048", user: user),
                                Client(name: "ТОВ РОГИ та КОПИТА", contactPerson: "Кидайло Василь (директор)", contact: "093-937-99-92", email: "uspih@ukr.net", idCode: "09873332", user: user)]

        tasks.forEach { RealmDBService.addObject(object: $0) }
        projects.forEach { RealmDBService.addObject(object: $0) }
        cliens.forEach { RealmDBService.addObject(object: $0) }
    }
}

