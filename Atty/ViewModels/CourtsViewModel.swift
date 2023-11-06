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
    
    static let shared = CourtsViewModel()
    
    let realm = try! Realm()
    
    private init() {}
    
    func observeMeets() -> Observable<[CourtMeet]> {
        return Observable.collection(from: realm.objects(CourtMeet.self))
            .map { results in
                return results.toArray()
            }
    }
    
    func observeTodayMeets() -> Observable<[CourtMeet]> {
        return Observable.collection(from: realm.objects(CourtMeet.self))
            .map { results in
                return results.toArray()
                    .sorted(by: { $0.date < $1.date })
                    .filter { self.compareDates(date: $0.date) }
            }
    }
    
    func getTodayMeets() -> [CourtMeet] {
        return RealmDBService.shared.getObjects(CourtMeet.self)
            .filter { compareDates(date: $0.date) }
            .sorted(by: { $0.date < $1.date })
    }
    
    func compareDates(date: Date) -> Bool {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .month, .year], from: date)
        let currentDate = calendar.dateComponents([.day, .month, .year], from: Date())
        
        return components.day == currentDate.day && components.month == currentDate.month && components.year == currentDate.year
    }
}

