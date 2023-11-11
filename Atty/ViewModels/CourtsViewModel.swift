//
//  CourtsViewModel.swift
//  Atty
//
//  Created by Nikita Melnikov on 05.11.2023.
//

import Foundation
import RealmSwift
import RxRealm
import RxCocoa
import RxSwift

class CourtsViewModel {
    
    static let realm = try! Realm()
    
    static var currentCase: CourtCase = CourtCase()
    
    static var statusSubject = PublishSubject<Bool>()
    
    static var statusFilter: Bool = true
    
    static func changeFilter() {
        statusFilter.toggle()
        statusSubject.onNext(statusFilter)
    }
    
    static func observeMeets() -> Observable<[CourtMeet]> {
        return Observable.collection(from: realm.objects(CourtMeet.self))
            .map { results in
                return results.toArray()
            }
    }
    
    static func observeCases() -> Observable<[CourtCase]> {
        return Observable.collection(from: realm.objects(CourtCase.self))
            .map { results in
                return results.toArray()
            }
    }
    
    static func observeTodayMeets() -> Observable<[CourtMeet]> {
        return Observable.collection(from: realm.objects(CourtMeet.self))
            .map { results in
                return results.toArray()
                    .sorted(by: { $0.date < $1.date })
                    .filter { self.compareDates(date: $0.date) }
            }
    }
    
    static func getTodayMeets() -> [CourtMeet] {
        return RealmDBService.shared.getObjects(CourtMeet.self)
            .filter { compareDates(date: $0.date) }
            .sorted(by: { $0.date < $1.date })
    }
    
    static func getCourtCases() -> [CourtCase] {
        return RealmDBService.shared.getObjects(CourtCase.self)
    }
    
    static func updateCourtCaseStatus(with courtCase: CourtCase, status: Bool) {
        RealmDBService.shared.updateCourtCaseStatus(with: courtCase, status: status)
    }
    
    static func compareDates(date: Date) -> Bool {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .month, .year], from: date)
        let currentDate = calendar.dateComponents([.day, .month, .year], from: Date())
        
        return components.day == currentDate.day && components.month == currentDate.month && components.year == currentDate.year
    }
}

