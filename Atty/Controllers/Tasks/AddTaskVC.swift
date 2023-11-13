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
    private var switcher: UISwitch!
    private var datePickerView: UIView!
    private var datePicker: UIDatePicker!
    
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
        switcher.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        
    }
}

private extension AddTaskVC {
    
    func addViews() {
        
        closeButton = UIButton(type: .system)
        closeButton.setImage(UIImage(named: "closeButton"), for: .normal)
        closeButton.tintColor = DS.Colors.standartTextColor
        view.addSubview(closeButton)
        
        label = UILabel()
        label.text = "Додати задачу"
        label.textColor = DS.Colors.standartTextColor
        label.font = UIFont(name: "Manrope-Bold", size: 40)
        label.numberOfLines = 2
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
        
        let switchView = UIView()
        stackView.addArrangedSubview(switchView)
        
        let switchLabel = UILabel()
        switchLabel.text = "Встановити дедлайн?"
        switchLabel.textColor = DS.Colors.standartTextColor
        switchLabel.font = UIFont(name: "Manrope-Bold", size: 20)
        switchLabel.adjustsFontSizeToFitWidth = true
        switchView.addSubview(switchLabel)
        
        switcher = UISwitch()
        switcher.isOn = false
        switchView.addSubview(switcher)
        
        datePickerView = UIView()
        datePickerView.isHidden = true
        stackView.addArrangedSubview(datePickerView)
        
        let dateLabel = UILabel()
        dateLabel.text = "Оберіть дату:"
        dateLabel.textColor = DS.Colors.standartTextColor
        dateLabel.font = UIFont(name: "Manrope-Bold", size: 20)
        dateLabel.adjustsFontSizeToFitWidth = true
        datePickerView.addSubview(dateLabel)
        
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        datePickerView.addSubview(datePicker)
        
        addButton = AuthButton(type: .system)
        addButton.setTitle("Додати", for: .normal)
        addButton.titleLabel?.font = UIFont(name: "Manrope-ExtraBold", size: 20)
        view.addSubview(addButton)
        
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
        
        taskDescriptionView.snp.makeConstraints {
            $0.height.equalTo(DS.Sizes.authTFHeight)
        }
        
        taskDescription.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(DS.Constraints.authTFInsets)
        }
        
        switchView.snp.makeConstraints {
            $0.height.equalTo(DS.Sizes.authTFHeight)
        }
        
        switchLabel.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(DS.Constraints.authTFInsets)
        }
        
        switcher.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(DS.Constraints.authTFInsets)
        }
        
        datePickerView.snp.makeConstraints {
            $0.height.equalTo(DS.Sizes.authTFHeight)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(DS.Constraints.authTFInsets)
        }
        
        datePicker.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(DS.Constraints.authTFInsets)
        }
        
        addButton.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).inset(-DS.Constraints.authViewLeadinTrailing)
            $0.height.equalTo(DS.Sizes.authTFHeight)
            $0.leading.trailing.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
            
        }
    }
}

extension AddTaskVC {
    
    @objc private func addTask() {
        guard let desc = taskDescription.text, !desc.isEmpty, let user = AuthViewModel.getCurrentUser() else { return }
        
        let task = switcher.isOn ? Task(desc: desc, deadline: datePicker.date, user: user) : Task(desc: desc, user: user)
        
        if let project_ = project {
            RealmDBService.addTaskToProject(task, to: project_)
        } else {
            TasksViewModel.addTask(with: task)
        }
        
        dismiss(animated: true)
    }
    
    @objc func switchValueChanged(_ sender: UISwitch) {
        datePickerView.isHidden = !sender.isOn
    }
    
    @objc private func tapClose() {
        dismiss(animated: true)
    }
}
