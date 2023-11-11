//
//  CourtCasesVC.swift
//  Atty
//
//  Created by Nikita Melnikov on 26.10.2023.
//

import Foundation
import UIKit
import SnapKit
import FirebaseAuth
import RxCocoa
import RxSwift
import BetterSegmentedControl

class CourtCasesVC: BaseViewContoller, CourtTVDelegate {
        
    private var disposeBag = DisposeBag()
    
    private var nextbtn: UIButton!
    private var valueLabel: UILabel!
    private var valueFromLabel: UILabel!
    private var segmentController: SegmentControllerView!
    private var tableView: UITableView!
    
    private var casesTV = CourtCasesTV()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        addSegmentController()
        
        casesTV.delegateCase = self
        
        addTable(with: casesTV)
        
        infoView.setAddView(title: "Додати")
        infoView.addInfoButton()
        infoView.infoButton.addTarget(self, action: #selector(addNewProject), for: .touchUpInside)
        
        CourtsViewModel.observeCases().subscribe(onNext: { event in
            let count = event.filter { $0.status == false }.count.description
            self.valueLabel.text = count
        }).disposed(by: disposeBag)
    }
    
    func didSelectCase(_ courtCase: CourtCase) {
//        let courtCaseInfoVC = CourtCaseInfoVC()
//        courtCaseInfoVC.courtCase = courtCase
//        navigationController?.pushViewController(projectInfoVC, animated: true)
    }
}

private extension CourtCasesVC {
    
    func addViews() {
        
        navigationBar.addTitle(with: Tabs.courtCases.itemTitle)
        
        let label = UILabel()
        label.text = "Відстежується"
        label.textColor = DS.Colors.standartTextColor
        label.font = UIFont(name: "Manrope-Bold", size: 100)
        label.adjustsFontSizeToFitWidth = true
        infoView.mainInfoView.addSubview(label)
        
        valueLabel = UILabel()
        valueLabel.textColor = DS.Colors.standartTextColor
        valueLabel.textAlignment = .center
        valueLabel.font = UIFont(name: "Manrope-Bold", size: 100)
        valueLabel.adjustsFontSizeToFitWidth = true
        infoView.mainInfoView.addSubview(valueLabel)
        
        
        label.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(DS.SizeMultipliers.twentyPercent)
            $0.top.leading.trailing.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
        valueLabel.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(DS.SizeMultipliers.fortyPercent)
            $0.top.equalTo(label.snp.bottom).inset(-DS.Constraints.authTFSpacing)
            $0.centerX.equalToSuperview()
        }
    }
    
    func addSegmentController() {
        
        segmentController = SegmentControllerView()
        segmentController.addController(with: ["Всі", "Засідання", "Архів"])
        segmentController.controller.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        contentView.addSubview(segmentController)
        
        segmentController.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(DS.SizeMultipliers.eightyPercent)
            $0.top.equalTo(infoView.snp.bottom).inset(-DS.Constraints.authViewLeadinTrailing)
            $0.leading.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
            $0.height.equalTo(contentView.snp.width).multipliedBy(DS.SizeMultipliers.tenPercent)
        }
    }
    
    func addTable(with table: UITableView) {
        
        tableView = table
        contentView.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(segmentController.snp.bottom).inset(-DS.Constraints.authViewLeadinTrailing)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    @objc func addNewProject() {
        let vc = AddProjectVC()
        present(vc, animated: true)
    }
    
    @objc func segmentedControlValueChanged(_ sender: BetterSegmentedControl) {
        
        tableView.removeFromSuperview()
        
        switch sender.index {
        case 0:
            CourtsViewModel.changeFilter()
            addTable(with: casesTV)
        case 1:
            addTable(with: casesTV)
        case 2:
            CourtsViewModel.changeFilter()
            addTable(with: casesTV)
        default:
            return
        }
    }
}
