//
//  Client.swift
//  Atty
//
//  Created by Nikita Melnikov on 09.11.2023.
//

import Foundation
import RealmSwift

class Client: Object {
    
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var name: String = ""
    @Persisted var contactPerson: String = ""
    @Persisted var contact: String = ""
    @Persisted var email: String = ""
    @Persisted var idCode: String = ""
    @Persisted var projects: List<Project> = List<Project>()
    @Persisted var status: Bool = false
    
    convenience init(name: String, contactPerson: String, contact: String, email: String, idCode: String) {
        self.init()
        self.name = name
        self.contactPerson = contactPerson
        self.contact = contact
        self.email = email
        self.idCode = idCode
    }
}

