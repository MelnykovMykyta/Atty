//
//  CourtCaseInfoTV.swift
//  Atty
//
//  Created by Nikita Melnikov on 11.11.2023.
//

import Foundation
import UIKit
import SnapKit
import RxCocoa
import RxSwift

class CourtCaseInfoTV: UITableView {
    
    private var disposeBag = DisposeBag()
    
    private let meet = "CourtMeetTVC"
    
    private var courtCase: CourtCase = CourtsViewModel.currentCase
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.delegate = self
        self.dataSource = self
        
        separatorStyle = .none
        showsVerticalScrollIndicator = false
        backgroundColor = .clear
        
        self.register(CourtMeetTVC.self, forCellReuseIdentifier: meet)

        CourtsViewModel.observeCases().subscribe({ event in
            self.courtCase = CourtsViewModel.currentCase
            self.reloadData()
        }).disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension CourtCaseInfoTV: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let meetCell = tableView.dequeueReusableCell(withIdentifier: "CourtMeetTVC") as? CourtMeetTVC else {
            return UITableViewCell()
        }
        
        meetCell.addFullCourtCase(courtName: courtCase.courtName, caseNumber: courtCase.caseNumber, plaintiff: courtCase.plaintiff, defendant: courtCase.defendant, disputeSubject: courtCase.disputeSubject, client: courtCase.client?.name ?? "", judge: courtCase.judge)
            meetCell.selectionStyle = .none

        return meetCell
    }
}

