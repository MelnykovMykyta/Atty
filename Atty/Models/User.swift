//
//  User.swift
//  Atty
//
//  Created by Nikita Melnikov on 11.11.2023.
//

import Foundation
import RealmSwift

class User: Object {
    @Persisted(primaryKey: true) var email: String = ""
    @Persisted var name: String = ""
    @Persisted var status: String = ""
    @Persisted var courtCases: List<String> = List<String>()
    
    convenience init(email: String, name: String, status: String) {
        self.init()
        self.email = email
        self.name = name
        self.status = status
    }
}
