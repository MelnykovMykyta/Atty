//
//  AddClientVC.swift
//  Atty
//
//  Created by Nikita Melnikov on 09.11.2023.
//

import Foundation
import UIKit
import SnapKit

class AddClientVC: UIViewController, UITextFieldDelegate {
    
    private var closeButton: UIButton!
    private var addButton: AuthButton!
    private var clientNameView: AuthTFView!
    private var contactView: AuthTFView!
    private var contactPersonView: AuthTFView!
    private var emailView: AuthTFView!
    private var idCodeView: AuthTFView!
    private var clientName: UITextField!
    private var contact: UITextField!
    private var contactPerson: UITextField!
    private var email: UITextField!
    private var idCode: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = DS.Colors.mainBackgroundColor
        
        addViews()
        
        self.addKeyboardDismissGesture()
        
        addButton.addTarget(self, action: #selector(addClient), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(tapClose), for: .touchUpInside)
    }
}

private extension AddClientVC {
    
    func addViews() {
        
        closeButton = UIButton(type: .system)
        closeButton.setImage(UIImage(named: "closeButton"), for: .normal)
        closeButton.tintColor = DS.Colors.standartTextColor
        view.addSubview(closeButton)
        
        let label = UILabel()
        label.text = "Додати клієнта"
        label.textColor = DS.Colors.standartTextColor
        label.font = UIFont(name: "Manrope-Bold", size: 40)
        label.adjustsFontSizeToFitWidth = true
        view.addSubview(label)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        view.addSubview(stackView)
        
        clientNameView = AuthTFView()
        stackView.addArrangedSubview(clientNameView)
        
        clientName = UITextField()
        clientName.backgroundColor = .clear
        clientName.placeholder = "Введіть назву ім'я / назву"
        clientNameView.addSubview(clientName)
        
        contactView = AuthTFView()
        stackView.addArrangedSubview(contactView)
        
        contact = UITextField()
        contact.backgroundColor = .clear
        contact.keyboardType = .numberPad
        contact.placeholder = "Введіть контактний номер"
        contactView.addSubview(contact)
        
        contactPersonView = AuthTFView()
        stackView.addArrangedSubview(contactPersonView)
        
        contactPerson = UITextField()
        contactPerson.backgroundColor = .clear
        contactPerson.placeholder = "Введіть контактну особу"
        contactPersonView.addSubview(contactPerson)
        
        emailView = AuthTFView()
        stackView.addArrangedSubview(emailView)
        
        email = UITextField()
        email.backgroundColor = .clear
        email.placeholder = "Введіть email"
        email.keyboardType = .emailAddress
        emailView.addSubview(email)
        
        idCodeView = AuthTFView()
        stackView.addArrangedSubview(idCodeView)
        
        idCode = UITextField()
        idCode.backgroundColor = .clear
        idCode.placeholder = "Ідентифікаційний код"
        idCode.keyboardType = .numberPad
        idCodeView.addSubview(idCode)
        
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
            $0.leading.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).inset(-DS.Constraints.authLogoLeadingTrailing)
            $0.leading.trailing.equalToSuperview().inset(DS.Constraints.authViewLeadinTrailing)
        }
        
        [clientNameView, contactView, contactPersonView, emailView, idCodeView, addButton]
            .forEach { element in
                element.snp.makeConstraints {
                    $0.height.equalTo(DS.Sizes.authTFHeight)
                }
            }
        [clientName, contact, contactPerson, email, idCode]
            .forEach { element in
                element.snp.makeConstraints {
                    $0.edges.equalToSuperview().inset(DS.Constraints.authTFInsets)
                }
            }
    }
}

extension AddClientVC {
    
    @objc private func addClient() {
        
        guard let name = clientName.text,
              let contact = contact.text,
              let contactPerson = contactPerson.text,
              let email = email.text,
              let idCode = idCode.text,
              !name.isEmpty,
              let user = AuthViewModel.getCurrentUser()
        else { return }
        
        if !name.isEmpty {
            ClientsViewModel.addClient(with: Client(name: name, contactPerson: contactPerson, contact: contact, email: email, idCode: idCode, user: user))
        }
        
        dismiss(animated: true)
    }
    
    @objc private func tapClose() {
        dismiss(animated: true)
    }
}
