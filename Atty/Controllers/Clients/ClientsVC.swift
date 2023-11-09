//
//  ClientsVC.swift
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

class ClientsVC: BaseViewContoller, ClientsTVDelegate {
    
    private var disposeBag = DisposeBag()
    
    private var nextbtn: UIButton!
    private var valueLabel: UILabel!
    private var segmentController: BetterSegmentedControl!
    private var tableView: UITableView!
    
    private var clients = ClientsTV()
    private var archive = ArchiveClientsTV()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        addSegmentController()
        
        clients.delegateClient = self
        archive.delegateClient = self
        
        addTable(with: clients)
        
        infoView.setAddView(title: "Додати клієнта")
        infoView.addInfoButton()
        infoView.infoButton.addTarget(self, action: #selector(addNewClient), for: .touchUpInside)
        
        ClientsViewModel.shared.observeClients().subscribe(onNext: { event in
            let allCount = event.count.description
            self.valueLabel.text = allCount
        }).disposed(by: disposeBag)
    }
    
    func didSelectClient(_ client: Client) {
//        let clientInfoVC = ClientInfoVC()
//        clientInfoVC.client = client
//        navigationController?.pushViewController(clientInfoVC, animated: true)
    }
}

private extension ClientsVC {
    
    func addViews() {
        
        navigationBar.addTitle(with: Tabs.clients.itemTitle)
        
        let label = UILabel()
        label.text = "Кількість"
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
    
    @objc func addNewClient() {
        let vc = AddClientVC()
        present(vc, animated: true, completion: nil)
    }
    
    func addSegmentController() {
        
        segmentController = BetterSegmentedControl()
        contentView.addSubview(segmentController)
        segmentController.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(DS.SizeMultipliers.halfSize)
            $0.top.equalTo(infoView.snp.bottom).inset(-DS.Constraints.authViewLeadinTrailing)
            $0.leading.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
            $0.height.equalTo(contentView.snp.width).multipliedBy(DS.SizeMultipliers.tenPercent)
        }
        
        segmentController.segments = LabelSegment.segments(withTitles: ["Всі", "Архів"],
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
            addTable(with: clients)
        case 1:
            addTable(with: archive)
        default:
            return
        }
    }
    
}
