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
    
    static var meetsSubject = PublishSubject<[CourtMeet]>()
    
    static var allMeets: [CourtMeet] = [].sorted(by: { $0.date < $1.date })
    
    static var statusSubject = PublishSubject<Bool>()
    
    static var statusFilter: Bool = false
    
    static func changeFilter() {
        statusFilter.toggle()
        statusSubject.onNext(statusFilter)
    }
    
    static func appendMeet(meet: CourtMeet) {
        allMeets.append(meet)
        meetsSubject.onNext(allMeets)
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
                    .filter { $0.user == AuthViewModel.getCurrentUser() }
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
    
    static func getAllCourtCasesData() -> [CourtCaseDataApi] {
        var courtCases: [CourtCaseDataApi] = []
        NetworkService.fetchData(url: "https://testapiat.free.beeceptor.com/courtcase", completion: { (result: Result<[CourtCaseDataApi], Error>) in
            switch result {
            case .success(let data):
                courtCases = data
            case .failure(let error):
                print("Error: \(error)")
            }
        })
        return courtCases
    }
    
    static func getTodayMeets() -> [CourtMeet] {
        return RealmDBService.getObjects(CourtMeet.self)
            .filter { DateHelper.compareDates(date: $0.date) }
            .sorted(by: { $0.date < $1.date })
    }
    
    static func getAllMeets() -> [CourtMeet] {
        guard let user = AuthViewModel.getCurrentUser() else { return [] }
        return RealmDBService.getObjects(CourtMeet.self)
            .filter { user.courtCases.contains($0.caseNumber) }
            .sorted(by: { $0.date < $1.date })
    }
    
    static func getCourtCases() -> [CourtCase] {
        return RealmDBService.getObjects(CourtCase.self)
            .filter { $0.user == AuthViewModel.getCurrentUser() }
            .sorted { !$0.status && $1.status}
    }
    
    static func addCourtCase(with courtCase: CourtCase) {
        RealmDBService.addObject(object: courtCase)
    }
    
    static func updateCourtCaseStatus(with courtCase: CourtCase, status: Bool) {
        RealmDBService.updateCourtCaseStatus(with: courtCase, status: status)
    }
    
    static func fetchCourtMeets() {
        
        guard let user = AuthViewModel.getCurrentUser() else { return }
        
        if !user.courtCases.isEmpty {
            NetworkService.fetchData(url: "https://testapiat.free.beeceptor.com/courtmeets", completion: { (result: Result<[CourtMeetApi], Error>) in
                switch result {
                case .success(let data):
                    
                    let meetApiItems = data
                        .filter { user.courtCases.contains($0.caseNumber) }
                    allMeets = []
                    meetApiItems.forEach { meet in
                        appendMeet(meet: CourtMeet(courtName: meet.courtName, caseNumber: meet.caseNumber, plaintiff: meet.plaintiff, defendant: meet.defendant, judge: meet.judge, date: DateHelper.formateDateFromApi(date: meet.date) ?? Date()))
                    }
                    
                case .failure(let error):
                    print("Error: \(error)")
                }
                
            })
        }
    }
}
