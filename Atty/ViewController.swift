//
//  ViewController.swift
//  Atty
//
//  Created by Nikita Melnikov on 20.10.2023.
//

import Foundation
import UIKit
import SnapKit

class ViewController: UIViewController {
    var contentView = SignInView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(contentView)
        contentView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }


}

