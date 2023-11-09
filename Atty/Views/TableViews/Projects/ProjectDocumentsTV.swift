//
//  ProjectDocumentsTV.swift
//  Atty
//
//  Created by Nikita Melnikov on 08.11.2023.
//

import Foundation
import UIKit
import SnapKit
import RxCocoa
import RxSwift

class ProjectDocumentsTV: UITableView {
    
    private var disposeBag = DisposeBag()
    
    let project = "ProjectTVC"
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.delegate = self
        self.dataSource = self
        
        separatorStyle = .none
        showsVerticalScrollIndicator = false
        backgroundColor = .clear
        
        self.register(ProjectTVC.self, forCellReuseIdentifier: project)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension ProjectDocumentsTV: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let projectCell = tableView.dequeueReusableCell(withIdentifier: "ProjectTVC") as? ProjectTVC else {
            return UITableViewCell()
        }
        projectCell.emptyDocumetsList()
        return projectCell
    }
}
