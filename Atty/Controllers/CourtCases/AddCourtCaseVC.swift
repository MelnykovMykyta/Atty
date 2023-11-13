//
//  AddCourtCaseVC.swift
//  Atty
//
//  Created by Nikita Melnikov on 11.11.2023.
//

import Foundation
import UIKit
import SnapKit

class AddCourtCaseVC: UIViewController, UITextFieldDelegate {
    
    private var label: UILabel!
    private var closeButton: UIButton!
    private var addButton: AuthButton!
    private var courtCaseNumberView: AuthTFView!
    private var courtCaseNumber: UITextField!
    
    var project: Project?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = DS.Colors.mainBackgroundColor
        
        addViews()
        
        if let project_ = project {
            project = project_
            label.text = "Відстежувати справу по проєкту: \(project_.name)"
        }
        
        self.addKeyboardDismissGesture()
        
        addButton.addTarget(self, action: #selector(addCourtCase), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(tapClose), for: .touchUpInside)
    }
}

private extension AddCourtCaseVC {
    
    func addViews() {
        
        closeButton = UIButton(type: .system)
        closeButton.setImage(UIImage(named: "closeButton"), for: .normal)
        closeButton.tintColor = DS.Colors.standartTextColor
        view.addSubview(closeButton)
        
        label = UILabel()
        label.text = "Відстежувати справу"
        label.numberOfLines = 2
        label.textColor = DS.Colors.standartTextColor
        label.font = UIFont(name: "Manrope-Bold", size: 40)
        label.adjustsFontSizeToFitWidth = true
        view.addSubview(label)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        view.addSubview(stackView)
        
        courtCaseNumberView = AuthTFView()
        stackView.addArrangedSubview(courtCaseNumberView)
        
        courtCaseNumber = UITextField()
        courtCaseNumber.backgroundColor = .clear
        courtCaseNumber.placeholder = "Введіть номер справи"
        courtCaseNumberView.addSubview(courtCaseNumber)
        
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
        
        courtCaseNumberView.snp.makeConstraints {
            $0.height.equalTo(DS.Sizes.authTFHeight)
        }
        
        courtCaseNumber.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(DS.Constraints.authTFInsets)
        }
        
        addButton.snp.makeConstraints {
            $0.height.equalTo(DS.Sizes.authTFHeight)
        }
    }
}

extension AddCourtCaseVC {
    
    @objc private func addCourtCase() {
        
        guard let caseNumber = courtCaseNumber.text, !caseNumber.isEmpty else { return }
        
//                let project = Project(name: name, shortDesc: shortDesc, additionalDesc: additionalDesc, category: category)
//
//        if let project_ = project {
//            print("FOR PROJECT: \(project_.name)")
//            let a = CourtCase(caseNumber: "PROJECTTT", courtName: "Господарський", plaintiff: "ТОВ НООО", defendant: "ТОВ АААА", disputeSubject: "Стягнення коштыв 100000", judge: "ТИП")
//            RealmDBService.addCourtCaseToProject(a, to: project_)
//        } else {
//            print("SIMPLE")
//            let a = CourtCase(caseNumber: "112/1212/1223", courtName: "Господарський", plaintiff: "ТОВ НООО", defendant: "ТОВ АААА", disputeSubject: "Стягнення коштыв 100000", judge: "ТИП")
//            RealmDBService.addObject(object: a)
//                        ProjectsViewModel.addProject(with: project)
//        }
        
        dismiss(animated: true)
    }
    
    @objc private func tapClose() {
        dismiss(animated: true)
    }
}
