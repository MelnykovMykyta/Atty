//
//  CourtCase.swift
//  Atty
//
//  Created by Nikita Melnikov on 11.11.2023.
//

import Foundation
import RealmSwift

class CourtCase: Object {
    
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var caseNumber: String = ""
    @Persisted var courtName: String = ""
    @Persisted var plaintiff: String = ""
    @Persisted var defendant: String = ""
    @Persisted var disputeSubject: String = ""
    @Persisted var client: Client?
    @Persisted var project: Project?
    @Persisted var courtMeet: List<CourtMeet> = List<CourtMeet>()
    @Persisted var judge: String = ""
    @Persisted var status: Bool = false
    
    convenience init(caseNumber: String, courtName: String, plaintiff: String, defendant: String, disputeSubject: String, judge: String) {
        self.init()
        self.caseNumber = caseNumber
        self.courtName = courtName
        self.plaintiff = plaintiff
        self.defendant = defendant
        self.disputeSubject = disputeSubject
        self.judge = judge
    }
}
