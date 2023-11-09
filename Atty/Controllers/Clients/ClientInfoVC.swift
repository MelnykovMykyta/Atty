//
//  ClientInfoVC.swift
//  Atty
//
//  Created by Nikita Melnikov on 09.11.2023.
//

import Foundation
import UIKit
import SnapKit
import FirebaseAuth
import RxCocoa
import RxSwift
import BetterSegmentedControl

class ClientInfoVC: BaseViewContoller {
    
    private var disposeBag = DisposeBag()
    
    var client: Client = ClientsViewModel.currentClient
    
    private var nextbtn: UIButton!
    private var valueLabel: UILabel!
    private var valueFromLabel: UILabel!
    private var segmentController: BetterSegmentedControl!
    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.addBackButton(with: client.name)
        navigationBar.backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        addViews()
        
        addSegmentController()
        
        addTable(with: ClientInfoTV())
        infoView.setAddView(title: "Додати проєкт")
        infoView.addInfoButton()
        infoView.infoButton.addTarget(self, action: #selector(addNewProject), for: .touchUpInside)
        
        ClientsViewModel.shared.observeClients().subscribe(onNext: { event in
            let element = event.first(where: { $0.id == self.client.id })
            let count = element?.projects.filter {$0.status == false}.count.description
            self.valueLabel.text = count
        }).disposed(by: disposeBag)
    }
}

private extension ClientInfoVC {
    
    func addViews() {
        
        let label = UILabel()
        label.text = "Проєкти"
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
    
    @objc func addNewProject() {
        let vc = AddProjectVC()
        vc.client = client
        present(vc, animated: true, completion: nil)
    }
    
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }
    
    func addSegmentController() {
        
        segmentController = BetterSegmentedControl()
        contentView.addSubview(segmentController)
        segmentController.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(DS.SizeMultipliers.eightyPercent)
            $0.top.equalTo(infoView.snp.bottom).inset(-DS.Constraints.authViewLeadinTrailing)
            $0.leading.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
            $0.height.equalTo(contentView.snp.width).multipliedBy(DS.SizeMultipliers.tenPercent)
        }
        
        segmentController.segments = LabelSegment.segments(withTitles: ["Картка", "Проєкти", "Витрати"],
                                                           normalBackgroundColor: DS.Colors.mainViewColor,
                                                           normalFont: UIFont(name: "Manrope-Bold", size: 14),
                                                           normalTextColor: DS.Colors.darkedTextColor,
                                                           selectedBackgroundColor: DS.Colors.selectedSegmentControllerItem,
                                                           selectedFont: UIFont(name: "Manrope-Bold", size: 14),
                                                           selectedTextColor: DS.Colors.standartTextColor)
        
        segmentController.cornerRadius = segmentController.frame.height / 2
        segmentController.backgroundColor = DS.Colors.mainViewColor
        segmentController.indicatorViewBackgroundColor = DS.Colors.mainViewColor
        segmentController.indicatorViewBorderColor = DS.Colors.mainViewColor
        segmentController.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
    }
    
    func addTable(with table: UITableView) {
        tableView = table
        contentView.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(segmentController.snp.bottom).inset(-DS.Constraints.authViewLeadinTrailing)
            $0.leading.trailing.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
            $0.bottom.equalToSuperview()
        }
    }
    
    @objc func segmentedControlValueChanged(_ sender: BetterSegmentedControl) {
        
        tableView.removeFromSuperview()
        
        switch sender.index {
        case 0:
            addTable(with: ClientInfoTV())
        case 1:
            addTable(with: ProjectDocumentsTV())
        case 2:
            addTable(with: DoneProjectsTV())
        default:
            return
        }
    }
}

