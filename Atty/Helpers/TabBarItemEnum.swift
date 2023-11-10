//
//  TabBarItemEnum.swift
//  Atty
//
//  Created by Nikita Melnikov on 26.10.2023.
//

import Foundation
import UIKit

enum Tabs: Int {
    
    case projects
    case clients
    case main
    case courtCases
    case tasks
    
    var icon: UIImage {
        
        switch self {
        case .projects:
            return UIImage(named: "projectsIcon") ?? UIImage()
        case .clients:
            return UIImage(named: "clientsIcon") ?? UIImage()
        case .main:
            return UIImage(named: "mainIcon") ?? UIImage()
        case .courtCases:
            return UIImage(named: "courtsCasesIcon") ?? UIImage()
        case .tasks:
            return UIImage(named: "tasksIcon") ?? UIImage()
        }
    }
    
    var itemTitle: String {
        
        switch self {
            
        case .projects:
            return "Проєкти"
        case .clients:
            return "Клієнти"
        case .main:
            return "Головна"
        case .courtCases:
            return "Суди"
        case .tasks:
            return "Задачі"
        }
    }
    
    var itemBar: UITabBarItem {
        
        switch self {
            
        case .projects:
            return UITabBarItem(title: Tabs.projects.itemTitle, image: Tabs.projects.icon, tag: Tabs.projects.rawValue)
        case .clients:
            return  UITabBarItem(title: Tabs.clients.itemTitle, image: Tabs.clients.icon, tag: Tabs.clients.rawValue)
        case .main:
            return UITabBarItem(title: Tabs.main.itemTitle, image: Tabs.main.icon, tag: Tabs.main.rawValue)
        case .courtCases:
            return UITabBarItem(title: Tabs.courtCases.itemTitle, image: Tabs.courtCases.icon, tag: Tabs.courtCases.rawValue)
        case .tasks:
            return UITabBarItem(title: Tabs.tasks.itemTitle, image: Tabs.tasks.icon, tag: Tabs.tasks.rawValue)
        }
    }
}
