//
//  Task.swift
//  Atty
//
//  Created by Nikita Melnikov on 05.11.2023.
//

import Foundation
import RealmSwift

class Task: Object {
    
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var date = Date()
    @Persisted var desc: String
    @Persisted var status: Bool = false
    @Persisted var deadline: Date?
    @Persisted var user: User?
    
    convenience init(desc: String, user: User) {
        self.init()
        self.desc = desc
        self.user = user
    }
    
    convenience init(desc: String, deadline: Date, user: User) {
        self.init()
        self.desc = desc
        self.deadline = deadline
        self.user = user
    }
}
