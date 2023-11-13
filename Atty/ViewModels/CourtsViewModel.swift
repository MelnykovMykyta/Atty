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
    
    static var statusFilter: Bool = false
    
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
                    .filter { DateHelper.compareDates(date: $0.date) }
            }
    }
    
    static func getTodayMeets() -> [CourtMeet] {
        return RealmDBService.getObjects(CourtMeet.self)
            .filter { DateHelper.compareDates(date: $0.date) }
            .sorted(by: { $0.date < $1.date })
    }
    
    static func getAllMeets() -> [CourtMeet] {
        return RealmDBService.getObjects(CourtMeet.self)
            .sorted(by: { $0.date < $1.date })
    }
    
    static func getCourtCases() -> [CourtCase] {
        return RealmDBService.getObjects(CourtCase.self)
    }
    
    static func updateCourtCaseStatus(with courtCase: CourtCase, status: Bool) {
        RealmDBService.updateCourtCaseStatus(with: courtCase, status: status)
    }
}

