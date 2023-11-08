//
//  ProjectsViewModel.swift
//  Atty
//
//  Created by Nikita Melnikov on 07.11.2023.
//

import Foundation
import RealmSwift
import RxRealm
import RxCocoa
import RxSwift

class ProjectsViewModel {
    
    static let shared = ProjectsViewModel()
    
    static var currentProject: Project = Project()
    
    let realm = try! Realm()
    
    private init() {}
    
    func observeProjects() -> Observable<[Project]> {
        return Observable.collection(from: realm.objects(Project.self))
            .map { results in
                return results.toArray()
            }
    }
    
    func addProject(with project: Project) {
        RealmDBService.shared.addObject(object: project)
    }
    
    func getProjects() -> [Project] {
        return RealmDBService.shared.getObjects(Project.self).sorted { !$0.status && $1.status}
    }
    
    func updateProjectStatus(with project: Project, status: Bool) {
        RealmDBService.shared.updateProjectStatus(with: project, status: status)
    }
}

