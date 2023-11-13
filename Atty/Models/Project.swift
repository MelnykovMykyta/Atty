//
//  Project.swift
//  Atty
//
//  Created by Nikita Melnikov on 07.11.2023.
//

import Foundation
import RealmSwift

class Project: Object {
    
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var name: String = ""
    @Persisted var shortDesc: String = ""
    @Persisted var additionalDesc: String = ""
    @Persisted var status: Bool = false
    @Persisted var category: String
    @Persisted var tasks: List<Task> = List<Task>()
    @Persisted var courtCases: List<CourtCase> = List<CourtCase>()
    @Persisted var client: Client?
    @Persisted var user: User?
    
    convenience init(name: String, shortDesc: String, additionalDesc: String, category: String, user: User) {
        self.init()
        self.name = name
        self.shortDesc = shortDesc
        self.additionalDesc = additionalDesc
        self.category = category
        self.user = user
    }
}
