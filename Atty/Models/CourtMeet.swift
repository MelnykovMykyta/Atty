//
//  CourtMeet.swift
//  Atty
//
//  Created by Nikita Melnikov on 05.11.2023.
//

import Foundation
import RealmSwift

struct CourtMeetApi: Decodable {
    
    var courtName: String
    var caseNumber: String
    var plaintiff: String
    var defendant: String
    var judge: String
    var date: String
}

class CourtMeet: Object {
    
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var courtName: String
    @Persisted var caseNumber: String
    @Persisted var plaintiff: String
    @Persisted var defendant: String
    @Persisted var judge: String
    @Persisted var date: Date
    
    var time: String {
        return formatTime(date)
    }
    
    var day: String {
        return formatDay(date)
    }
    
    convenience init(courtName: String, caseNumber: String, plaintiff: String, defendant: String, judge: String, date: Date) {
        self.init()
        
        self.courtName = courtName
        self.caseNumber = caseNumber
        self.plaintiff = plaintiff
        self.defendant = defendant
        self.judge = judge
        self.date = date
    }
    
    func formatTime(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
    
    func formatDay(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: date)
    }
}

