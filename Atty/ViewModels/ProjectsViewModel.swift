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
    
    static let realm = try! Realm()
    
    static func observeProjects() -> Observable<[Project]> {
        return Observable.collection(from: realm.objects(Project.self))
            .map { results in
                return results.toArray()
            }
    }
    
    static func addProject(with project: Project) {
        RealmDBService.shared.addObject(object: project)
    }
    
    static func getProjects() -> [Project] {
        return RealmDBService.shared.getObjects(Project.self).sorted { !$0.status && $1.status}
    }
    
    static func getProjectCourtCases() -> [CourtCase] {
        return RealmDBService.shared.getObjects(CourtCase.self)
            .filter { $0.project == currentProject}
    }
    
    static func updateProjectStatus(with project: Project, status: Bool) {
        RealmDBService.shared.updateProjectStatus(with: project, status: status)
    }
}

