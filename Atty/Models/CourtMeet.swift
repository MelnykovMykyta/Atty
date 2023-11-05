//
//  CourtMeet.swift
//  Atty
//
//  Created by Nikita Melnikov on 05.11.2023.
//

import Foundation
import RealmSwift

class CourtMeet: Object {
    
    @Persisted var courtName: String
    @Persisted var caseNumber: String
    @Persisted var plaintiff: String
    @Persisted var defendant: String
    @Persisted var judge: String
    @Persisted var time: String
    @Persisted var date: String
    
    convenience init(courtName: String, caseNumber: String, plaintiff: String, defendant: String, judge: String, time: String, date: String) {
        self.init()
 
        self.courtName = courtName
        self.caseNumber = caseNumber
        self.plaintiff = plaintiff
        self.defendant = defendant
        self.judge = judge
        self.time = time
        self.date = date
    }

}

