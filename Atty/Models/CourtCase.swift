//
//  CourtCase.swift
//  Atty
//
//  Created by Nikita Melnikov on 11.11.2023.
//

import Foundation
import RealmSwift


struct CourtCaseDataApi: Decodable {
     var caseNumber: String
     var courtName: String
     var plaintiff: String
     var defendant: String
     var disputeSubject: String
     var judge: String
}

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
    @Persisted var user: User?
    
    convenience init(caseNumber: String, courtName: String, plaintiff: String, defendant: String, disputeSubject: String, judge: String, user: User) {
        self.init()
        self.caseNumber = caseNumber
        self.courtName = courtName
        self.plaintiff = plaintiff
        self.defendant = defendant
        self.disputeSubject = disputeSubject
        self.judge = judge
        self.user = user
    }
}
