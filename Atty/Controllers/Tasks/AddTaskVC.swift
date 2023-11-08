//
//  AddTaskVC.swift
//  Atty
//
//  Created by Nikita Melnikov on 06.11.2023.
//

import Foundation
import UIKit
import SnapKit


class AddTaskVC: UIViewController, UITextFieldDelegate {
    
    private var label: UILabel!
    private var closeButton: UIButton!
    private var addButton: AuthButton!
    private var taskDescriptionView: AuthTFView!
    private var taskDescription: UITextField!
    
    var project: Project?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = DS.Colors.mainBackgroundColor
        
        addViews()
        
        if let project_ = project {
            project = project_
            label.text = "Додати задачу до проєкту: \(project_.name)"
        }
        
        self.addKeyboardDismissGesture()
        
        addButton.addTarget(self, action: #selector(addTask), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(tapClose), for: .touchUpInside)
    }
}

private extension AddTaskVC {
    
    func addViews() {
        
        closeButton = UIButton(type: .system)
        closeButton.setImage(UIImage(named: "closeButton"), for: .normal)
        closeButton.tintColor = DS.Colors.standartTextColor
        view.addSubview(closeButton)
        
        label = UILabel()
        label.textColor = DS.Colors.standartTextColor
        label.font = UIFont(name: "Manrope-Bold", size: 50)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        view.addSubview(label)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        view.addSubview(stackView)
        
        taskDescriptionView = AuthTFView()
        stackView.addArrangedSubview(taskDescriptionView)
        
        taskDescription = UITextField()
        taskDescription.backgroundColor = .clear
        taskDescription.placeholder = "Введіть опис"
        taskDescriptionView.addSubview(taskDescription)
        
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
        
        taskDescriptionView.snp.makeConstraints { $0.height.equalTo(DS.Sizes.authTFHeight) }
        
        taskDescription.snp.makeConstraints { $0.edges.equalToSuperview().inset(DS.Constraints.authTFInsets) }
        
        addButton.snp.makeConstraints { $0.height.equalTo(DS.Sizes.authTFHeight) }
    }
}
    extension AddTaskVC {
        
        @objc private func addTask() {
            guard let desc = taskDescription.text, !desc.isEmpty else { return }
            let task = Task(desc: desc, status: false)
            if let project_ = project {
                RealmDBService.shared.addTaskToProject(task, to: project_)
            } else {
                TasksViewModel.shared.addTask(with: task)
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

