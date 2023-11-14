//
//  CourtMeetsTV.swift
//  Atty
//
//  Created by Nikita Melnikov on 11.11.2023.
//

import Foundation
import UIKit
import SnapKit
import RxCocoa
import RxSwift

class CourtMeetsTV: UITableView {
    
    private var disposeBag = DisposeBag()
    
    private let meet = "CourtMeetTVC"
    
    private var courtMeets: [CourtMeet] = CourtsViewModel.allMeets.sorted(by: { $0.date < $1.date })
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.delegate = self
        self.dataSource = self
        
        separatorStyle = .none
        showsVerticalScrollIndicator = false
        allowsSelection = false
        backgroundColor = .clear
        
        self.register(CourtMeetTVC.self, forCellReuseIdentifier: meet)
        
        CourtsViewModel.meetsSubject.subscribe(onNext: { event in
            self.courtMeets = CourtsViewModel.allMeets.sorted(by: { $0.date < $1.date })
            self.reloadData()
        }).disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension CourtMeetsTV: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        courtMeets.isEmpty ? 1 : courtMeets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let meetCell = tableView.dequeueReusableCell(withIdentifier: "CourtMeetTVC") as? CourtMeetTVC else {
            return UITableViewCell()
        }
        
        if courtMeets.isEmpty {
            meetCell.emptyCourtMeetsList(with: "По справам засідання відсутні")
        } else {
            let meet = courtMeets[indexPath.row]
            meetCell.addCourtMeet(courtName: meet.courtName, caseNumber: meet.caseNumber, plaintiff: meet.plaintiff,defendant: meet.defendant, judge: meet.judge, time: meet.time, date: meet.day)
        }
        return meetCell
    }
}
