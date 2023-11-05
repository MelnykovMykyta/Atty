////
////  MainTasksTV.swift
////  Atty
////
////  Created by Nikita Melnikov on 02.11.2023.
////
//
//import Foundation
//import UIKit
//import SnapKit
//
//class MainTasksTV: UITableView {
//
//    let task = "TaskTVC"
//
//    override init(frame: CGRect, style: UITableView.Style) {
//        super.init(frame: frame, style: style)
//        self.delegate = self
//        self.dataSource = self
//
//        separatorStyle = .none
//        allowsSelection = false
//        showsVerticalScrollIndicator = false
//        backgroundColor = .clear
//
//
//        self.register(TaskTVC.self, forCellReuseIdentifier: task)
//        rowHeight = UITableView.automaticDimension
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//extension MainTasksTV: UITableViewDelegate, UITableViewDataSource {
//
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let taskCell = tableView.dequeueReusableCell(withIdentifier: "TaskTVC") as! TaskTVC
//        taskCell.addTask(title: "Забрати аванс у того самого клієнта", completionStatus: false)
//        return taskCell
//    }
//}
