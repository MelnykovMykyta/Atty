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
            return UITabBarItem(title: nil, image: Tabs.projects.icon, tag: Tabs.projects.rawValue)
        case .clients:
            return  UITabBarItem(title: nil, image: Tabs.clients.icon, tag: Tabs.clients.rawValue)
        case .main:
            return UITabBarItem(title: nil, image: Tabs.main.icon, tag: Tabs.main.rawValue)
        case .courtCases:
            return UITabBarItem(title: nil, image: Tabs.courtCases.icon, tag: Tabs.courtCases.rawValue)
        case .tasks:
            return UITabBarItem(title: nil, image: Tabs.tasks.icon, tag: Tabs.tasks.rawValue)
        }
    }
}
