//
//  MainVC.swift
//  Atty
//
//  Created by Nikita Melnikov on 24.10.2023.
//

import Foundation
import UIKit
import SnapKit
import FirebaseAuth
import RxCocoa
import RxSwift

class MainVC: UIViewController, UITextFieldDelegate {
    
    private var disposeBag = DisposeBag()
    
    private var navigationBar: BaseNavBarView!
    private var contentView: UIView!
    private var infoView: MainInfoView!
    private var tableView: MainTV!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraintViews()
        
        TasksViewModel.shared.observeTasks().subscribe(onNext: { event in
            let count = event.filter { $0.status == false }.count.description
            self.infoView.tasksValue.text = count
        }).disposed(by: disposeBag)
        
        CourtsViewModel.observeTodayMeets().subscribe(onNext: { event in
            let count = event.count.description
            self.infoView.courtMeetsValue.text = count
        }).disposed(by: disposeBag)
    }
}

extension MainVC {
    
    private func setupViews() {
        
        view.backgroundColor = DS.Colors.mainBackgroundColor
        
        navigationBar = BaseNavBarView()
        view.addSubview(navigationBar)
        
        contentView = UIView()
        contentView.backgroundColor = DS.Colors.mainViewColor
        contentView.layer.cornerRadius = DS.CornerRadius.baseCornerRadiusLayers
        contentView.layer.masksToBounds = true
        view.addSubview(contentView)
        
        navigationBar.addUser(name: "Микита Мельников", status: "Адвокат", icon: nil)
        navigationBar.userIcon.addTarget(self, action: #selector(logouttap), for: .touchUpInside)
        
        infoView = MainInfoView()
        contentView.addSubview(infoView)
        
        infoView.dateLabel.text = formatDate(Date())
        infoView.costsButton.addTarget(self, action: #selector(tapCostsInfo), for: .touchUpInside)
        
        tableView = MainTV()
        contentView.addSubview(tableView)
    }
    
    func setupConstraintViews() {
        
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        infoView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(infoView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}

private extension MainVC {
    
    @objc func logouttap() {
        FirebaseAuthService.shared.logout()
    }
    
    @objc func tapCostsInfo() {
        Alert.shared.showAlert(title: "Скоро", message: "Цей розділ ще в розробці")
    }
    
    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        dateFormatter.locale = Locale(identifier: "uk_UA")
        return dateFormatter.string(from: date)
    }
}
