//
//  MainTV.swift
//  Atty
//
//  Created by Nikita Melnikov on 02.11.2023.
//

import Foundation
import UIKit
import SnapKit

class MainTV: UITableView {
    
    let header = "HeaderTVC"
    let task = "TaskTVC"
    let meet = "CourtMeetTVC"
    
    var tasks: [Task] = RealmDBService.shared.getTasks()
    
    var courtMeets: [CourtMeet] = [CourtMeet(courtName: "Господарський суд міста Києва", caseNumber: "№ 911/12212/19", plaintiff: "ТОВ “НАНО”", defendant: "ТОВ “Консалт плюс”", judge: "Коваленко А. І.", time: "09:45", date: "27.10.2023")]
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        RealmDBService.shared.addDefaults()
        self.delegate = self
        self.dataSource = self
        
        separatorStyle = .none
        allowsSelection = false
        showsVerticalScrollIndicator = false
        backgroundColor = .clear
        
        self.register(HeaderTVC.self, forCellReuseIdentifier: header)
        self.register(TaskTVC.self, forCellReuseIdentifier: task)
        self.register(CourtMeetTVC.self, forCellReuseIdentifier: meet)
  
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension MainTV: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        case 1:
            if tasks.isEmpty {
                return 1
            } else {
               return tasks.count
            }
        case 3:
            if courtMeets.isEmpty {
                return 1
            } else {
               return courtMeets.count
            }
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderTVC") as! HeaderTVC
        let tasksCell = tableView.dequeueReusableCell(withIdentifier: "TaskTVC") as! TaskTVC
        let meetCell = tableView.dequeueReusableCell(withIdentifier: "CourtMeetTVC") as! CourtMeetTVC
        
        switch indexPath.section {
            
        case 0:
            headerCell.addViews(title: "Задачі", buttonTitle: "Всі задачі")
            return headerCell
            
        case 1:
            if tasks.isEmpty {
                tasksCell.emptyTasksList()
            } else {
                tasksCell.addTask(title: tasks[indexPath.row].desc, completionStatus: tasks[indexPath.row].status)
            }
            return tasksCell
            
        case 2:
            headerCell.addViews(title: "Засідання", buttonTitle: "Більше")
            return headerCell
            
        case 3:
    
            if courtMeets.isEmpty {
                meetCell.emptyCourtMeetsList()
            } else {
                meetCell.addCourtMeet(courtName: courtMeets[indexPath.row].courtName,
                                      caseNumber: courtMeets[indexPath.row].caseNumber,
                                      plaintiff: courtMeets[indexPath.row].plaintiff,
                                      defendant: courtMeets[indexPath.row].defendant,
                                      judge: courtMeets[indexPath.row].judge,
                                      time: courtMeets[indexPath.row].time,
                                      date: courtMeets[indexPath.row].date)
            }
            return meetCell
            
        case 4:
            headerCell.addViews(title: "Новини", buttonTitle: "Більше")
            return headerCell
        case 5:
            return headerCell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
            if indexPath.section == 1 {
                let swipe = UIContextualAction(style: .destructive, title: "Виконано") { (action, view, success) in
                    let task = self.tasks[indexPath.row]
                    self.taskSuccess(task: task, indexPath: indexPath)
                    success(true)
                }
                return UISwipeActionsConfiguration(actions: [swipe])
            }
            return UISwipeActionsConfiguration()
        }
    
    private func taskSuccess (task: Task, indexPath: IndexPath) {
            
        task.status = true
            reloadData()
        }
}
