//
//  TasksVC.swift
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

class TasksVC: BaseViewContoller {
    
    private var disposeBag = DisposeBag()
    
    private var nextbtn: UIButton!
    private var valueLabel: UILabel!
    private var valueFromLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        
        TasksViewModel.shared.observeTasks().subscribe(onNext: { event in
            let count = event.filter { $0.status == true }.count.description
            let allCount = event.count.description
            self.valueLabel.text = count
            self.valueFromLabel.text = allCount
        }).disposed(by: disposeBag)
    }
}

private extension TasksVC {
    
    func addViews() {
        
        navigationBar.addTitle(with: Tabs.tasks.itemTitle)
        
        let label = UILabel()
        label.text = "Завершені"
        label.textColor = DS.Colors.standartTextColor
        label.font = UIFont(name: "Manrope-Bold", size: 100)
        label.adjustsFontSizeToFitWidth = true
        infoView.mainInfoView.addSubview(label)
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        infoView.mainInfoView.addSubview(stackView)
        
        valueLabel = UILabel()
        valueLabel.textColor = DS.Colors.standartTextColor
        valueLabel.textAlignment = .right
        valueLabel.font = UIFont(name: "Manrope-Bold", size: 100)
        valueLabel.adjustsFontSizeToFitWidth = true
        stackView.addArrangedSubview(valueLabel)
        
        let separator = UILabel()
        separator.text = "/"
        separator.textColor = DS.Colors.standartTextColor
        separator.textAlignment = .center
        separator.font = UIFont(name: "Manrope-Bold", size: 100)
        separator.adjustsFontSizeToFitWidth = true
        stackView.addArrangedSubview(separator)
        
        valueFromLabel = UILabel()
        valueFromLabel.textColor = DS.Colors.standartTextColor
        valueFromLabel.textAlignment = .left
        valueFromLabel.font = UIFont(name: "Manrope-Bold", size: 100)
        valueFromLabel.adjustsFontSizeToFitWidth = true
        stackView.addArrangedSubview(valueFromLabel)
        
        label.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(DS.SizeMultipliers.twentyPercent)
            $0.top.leading.trailing.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
        stackView.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(DS.SizeMultipliers.fortyPercent)
            $0.top.equalTo(label.snp.bottom).inset(-DS.Constraints.authTFSpacing)
            $0.centerX.equalToSuperview()
        }
        
        valueLabel.snp.makeConstraints {
            $0.height.equalToSuperview()
        }
        
        separator.snp.makeConstraints {
            $0.height.equalToSuperview()
        }
        
        valueFromLabel.snp.makeConstraints {
            $0.height.equalToSuperview()
        }
        
        infoView.setAddView(title: "Додати задачу")
        infoView.addInfoButton()
        infoView.infoButton.addTarget(self, action: #selector(addNewTask), for: .touchUpInside)
        addtable(with: TasksTV())
    }
    
    @objc func addNewTask() {
        let vc = AddTaskVC()
        present(vc, animated: true, completion: nil)
    }
}
