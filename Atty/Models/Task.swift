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
    @Persisted var desc: String
    @Persisted var status: Bool
    
    convenience init(desc: String, status: Bool) {
        self.init()
        
        self.desc = desc
        self.status = status
    }
}
