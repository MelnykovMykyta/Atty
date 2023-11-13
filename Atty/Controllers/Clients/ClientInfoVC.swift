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
    
    private var valueLabel: UILabel!
    private var segmentController: SegmentControllerView!
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
        
        ClientsViewModel.observeClients().subscribe(onNext: { event in
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
    
    func addSegmentController() {
        
        segmentController = SegmentControllerView()
        segmentController.addController(with: ["Картка", "Проєкти", "Витрати"])
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
        vc.client = client
        present(vc, animated: true)
    }
    
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func segmentedControlValueChanged(_ sender: BetterSegmentedControl) {
        
        tableView.removeFromSuperview()
        
        switch sender.index {
        case 0:
            addTable(with: ClientInfoTV())
        case 1:
            addTable(with: ClientProjectsTV())
        case 2:
            Alert.showAlert(title: "Скоро", message: "Цей розділ в розробці")
        default:
            return
        }
    }
}
