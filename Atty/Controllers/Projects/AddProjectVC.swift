//
//  AddProjectVC.swift
//  Atty
//
//  Created by Nikita Melnikov on 07.11.2023.
//

import Foundation
import UIKit
import SnapKit

class AddProjectVC: UIViewController, UITextFieldDelegate {
    
    private var label: UILabel!
    private var closeButton: UIButton!
    private var addButton: AuthButton!
    private var projectNameView: AuthTFView!
    private var projectShortDeskView: AuthTFView!
    private var projectAdditionalDescView: AuthTFView!
    private var projectCategoryView: AuthTFView!
    private var projectName: UITextField!
    private var projectShortDesc: UITextField!
    private var projectAdditionalDesc: UITextField!
    private var projectCategory: UITextField!
    
    var client: Client?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = DS.Colors.mainBackgroundColor
        
        addViews()
        
        if let client_ = client {
            client = client_
            label.text = "Додати проєкт до клієнта: \(client_.name)"
        }
        
        self.addKeyboardDismissGesture()
        
        addButton.addTarget(self, action: #selector(addProject), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(tapClose), for: .touchUpInside)
    }
}

private extension AddProjectVC {
    
    func addViews() {
        
        closeButton = UIButton(type: .system)
        closeButton.setImage(UIImage(named: "closeButton"), for: .normal)
        closeButton.tintColor = DS.Colors.standartTextColor
        view.addSubview(closeButton)
        
        label = UILabel()
        label.text = "Додати проєкт"
        label.numberOfLines = 2
        label.textColor = DS.Colors.standartTextColor
        label.font = UIFont(name: "Manrope-Bold", size: 40)
        label.adjustsFontSizeToFitWidth = true
        view.addSubview(label)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        view.addSubview(stackView)
        
        projectNameView = AuthTFView()
        stackView.addArrangedSubview(projectNameView)
        
        projectName = UITextField()
        projectName.backgroundColor = .clear
        projectName.placeholder = "Введіть назву проєкта"
        projectNameView.addSubview(projectName)
        
        projectShortDeskView = AuthTFView()
        stackView.addArrangedSubview(projectShortDeskView)
        
        projectShortDesc = UITextField()
        projectShortDesc.backgroundColor = .clear
        projectShortDesc.placeholder = "Введіть короткий опис проєкта"
        projectShortDeskView.addSubview(projectShortDesc)
        
        projectAdditionalDescView = AuthTFView()
        stackView.addArrangedSubview(projectAdditionalDescView)
        
        projectAdditionalDesc = UITextField()
        projectAdditionalDesc.backgroundColor = .clear
        projectAdditionalDesc.placeholder = "Введіть додатковий опис"
        projectAdditionalDescView.addSubview(projectAdditionalDesc)
        
        projectCategoryView = AuthTFView()
        stackView.addArrangedSubview(projectCategoryView)
        
        projectCategory = UITextField()
        projectCategory.backgroundColor = .clear
        projectCategory.placeholder = "Введіть категорію"
        projectCategoryView.addSubview(projectCategory)
        
        addButton = AuthButton(type: .system)
        addButton.setTitle("Додати", for: .normal)
        addButton.titleLabel?.font = UIFont(name: "Manrope-ExtraBold", size: 20)
        stackView.addArrangedSubview(addButton)
        
        closeButton.snp.makeConstraints {
            $0.size.equalTo(DS.Sizes.buttonSize)
            $0.top.trailing.equalToSuperview().inset(DS.Constraints.navigationBarItem)
        }
        
        label.snp.makeConstraints {
            $0.top.equalToSuperview().inset(DS.Constraints.authLogoLeadingTrailing)
            $0.leading.trailing.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).inset(-DS.Constraints.authLogoLeadingTrailing)
            $0.leading.trailing.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
        projectNameView.snp.makeConstraints { $0.height.equalTo(DS.Sizes.authTFHeight) }
        
        projectShortDeskView.snp.makeConstraints { $0.height.equalTo(DS.Sizes.authTFHeight) }
        
        projectAdditionalDescView.snp.makeConstraints { $0.height.equalTo(DS.Sizes.authTFHeight) }
        
        projectCategoryView.snp.makeConstraints { $0.height.equalTo(DS.Sizes.authTFHeight) }
        
        projectName.snp.makeConstraints { $0.edges.equalToSuperview().inset(DS.Constraints.authTFInsets) }
        
        projectShortDesc.snp.makeConstraints { $0.edges.equalToSuperview().inset(DS.Constraints.authTFInsets) }
        
        projectAdditionalDesc.snp.makeConstraints { $0.edges.equalToSuperview().inset(DS.Constraints.authTFInsets) }
        
        projectCategory.snp.makeConstraints { $0.edges.equalToSuperview().inset(DS.Constraints.authTFInsets) }
        
        addButton.snp.makeConstraints { $0.height.equalTo(DS.Sizes.authTFHeight) }
    }
}

extension AddProjectVC {
    
    @objc private func addProject() {
        
        guard let name = projectName.text,
              let shortDesc = projectShortDesc.text,
              let additionalDesc = projectAdditionalDesc.text,
              let category = projectCategory.text,
              !name.isEmpty
        else { return }
        let project = Project(name: name, shortDesc: shortDesc, additionalDesc: additionalDesc, category: category)
        
        if let client_ = client {
            RealmDBService.shared.addProjectToClient(project, to: client_)
            
        } else {
            ProjectsViewModel.shared.addProject(with: project)
        }
        
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func tapClose() {
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
