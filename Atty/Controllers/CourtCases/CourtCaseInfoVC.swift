//
//  CourtCaseInfoVC.swift
//  Atty
//
//  Created by Nikita Melnikov on 11.11.2023.
//

import Foundation
import UIKit
import SnapKit
import FirebaseAuth
import RxCocoa
import RxSwift
import BetterSegmentedControl

class CourtCaseInfoVC: BaseViewContoller {
    
    private var disposeBag = DisposeBag()
    
    var courtCase: CourtCase?
    
    private var valueLabel: UILabel!
    private var segmentController: SegmentControllerView!
    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let courtCase_ = courtCase { courtCase = courtCase_ }
        
        navigationBar.addBackButton(with: courtCase?.caseNumber ?? "")
        navigationBar.backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        addViews()
        
        addSegmentController()
        
        addTable(with: CourtCaseInfoTV())
        
        infoView.setAddView(title: "Додати")
        infoView.addInfoButton()
        infoView.infoButton.addTarget(self, action: #selector(addCourtCase), for: .touchUpInside)
        
        CourtsViewModel.observeCases().subscribe(onNext: { event in
            let count = event.filter { $0.status == false }.count.description
            self.valueLabel.text = count
        }).disposed(by: disposeBag)
    }
}

private extension CourtCaseInfoVC {
    
    func addViews() {
        
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
        segmentController.addController(with: ["Картка", "Рішення", "Засідання"])
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
    
    @objc func addCourtCase() {
        let vc = AddCourtCaseVC()
        present(vc, animated: true)
    }
    
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func segmentedControlValueChanged(_ sender: BetterSegmentedControl) {
        
        tableView.removeFromSuperview()
        
        switch sender.index {
        case 0:
            addTable(with: CourtCaseInfoTV())
        case 1:
            Alert.showAlert(title: "Скоро", message: "Цей розділ в розробці")
        case 2:
            addTable(with: CourtCaseInfoMeetsTV())
        default:
            return
        }
    }
}

