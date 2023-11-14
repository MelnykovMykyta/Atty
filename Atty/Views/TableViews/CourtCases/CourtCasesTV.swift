//
//  CourtCasesTV.swift
//  Atty
//
//  Created by Nikita Melnikov on 11.11.2023.
//

import Foundation
import UIKit
import SnapKit
import RxCocoa
import RxSwift

protocol CourtTVDelegate {
    func didSelectCase(_ courtCase: CourtCase)
}

class CourtCasesTV: UITableView {
    
    private var disposeBag = DisposeBag()
    
    var delegateCase: CourtTVDelegate?
    
    private let meet = "CourtMeetTVC"
    
    private var courtCases: [CourtCase] = CourtsViewModel.getCourtCases()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.delegate = self
        self.dataSource = self
        
        separatorStyle = .none
        showsVerticalScrollIndicator = false
        backgroundColor = .clear
        
        self.register(CourtMeetTVC.self, forCellReuseIdentifier: meet)
        
        CourtsViewModel.statusSubject.subscribe({ event in
            self.courtCases = CourtsViewModel.getCourtCases()
            self.reloadData()
        }).disposed(by: disposeBag)
        
        CourtsViewModel.observeCases().subscribe(onNext: { event in
            self.courtCases = CourtsViewModel.getCourtCases()
            self.reloadData()
        }).disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension CourtCasesTV: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        courtCases.isEmpty ? 1 : courtCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let meetCell = tableView.dequeueReusableCell(withIdentifier: "CourtMeetTVC") as? CourtMeetTVC else {
            return UITableViewCell()
        }
        
        if courtCases.isEmpty {
            meetCell.emptyCourtMeetsList(with: "Список відстеження порожній")
        } else {
            let caseItem = courtCases[indexPath.row]
            meetCell.addCourtCase(courtName: caseItem.courtName, caseNumber: caseItem.caseNumber, plaintiff: caseItem.plaintiff, defendant: caseItem.defendant, judge: caseItem.judge, status: caseItem.status)
            meetCell.selectionStyle = .none
        }
        return meetCell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let caseItem = self.courtCases[indexPath.row]
        
        if !courtCases.isEmpty && !caseItem.status {
            let swipe = UIContextualAction(style: .destructive, title: "В архів") { (action, view, success) in
                CourtsViewModel.updateCourtCaseStatus(with: caseItem, status: true)
                success(true)
            }
            return UISwipeActionsConfiguration(actions: [swipe])
        }
        return UISwipeActionsConfiguration()
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let caseItem = self.courtCases[indexPath.row]
        
        if !courtCases.isEmpty && caseItem.status {
            let swipe = UIContextualAction(style: .destructive, title: "Актуально") { (action, view, success) in
                CourtsViewModel.updateCourtCaseStatus(with: caseItem, status: false)
                success(true)
            }
            swipe.backgroundColor = DS.Colors.taskFinished
            
            return UISwipeActionsConfiguration(actions: [swipe])
        }
        return UISwipeActionsConfiguration()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !courtCases.isEmpty {
            let selectedCase = courtCases[indexPath.row]
            delegateCase?.didSelectCase(selectedCase)
            
            CourtsViewModel.currentCase = selectedCase
        }
    }
}
