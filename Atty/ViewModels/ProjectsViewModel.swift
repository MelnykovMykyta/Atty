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
    
    static let realm = try! Realm()
    
    static var currentProject: Project = Project()
    
    static func observeProjects() -> Observable<[Project]> {
        return Observable.collection(from: realm.objects(Project.self))
            .map { results in
                return results.toArray()
                    .filter { $0.user == AuthViewModel.getCurrentUser() }
            }
    }
    
    static func addProject(with project: Project) {
        RealmDBService.addObject(object: project)
    }
    
    static func getProjects() -> [Project] {
        return RealmDBService.getObjects(Project.self)
            .filter { $0.user == AuthViewModel.getCurrentUser() }
            .sorted { !$0.status && $1.status}
    }
    
    static func getProjectCourtCases() -> [CourtCase] {
        return RealmDBService.getObjects(CourtCase.self)
//            .filter { $0.user == AuthViewModel.getCurrentUser() }
            .filter { $0.project == currentProject}
    }
    
    static func updateProjectStatus(with project: Project, status: Bool) {
        RealmDBService.updateProjectStatus(with: project, status: status)
    }
}

