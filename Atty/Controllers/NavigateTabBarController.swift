//
//  NavigateTabBarController.swift
//  Atty
//
//  Created by Nikita Melnikov on 26.10.2023.
//

import Foundation
import UIKit

class NavigateTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        self.delegate = self
    }
}

private extension NavigateTabBarController {
    
    func setupViews() {
        
        tabBar.tintColor = DS.Colors.standartTextColor
        tabBar.barTintColor = DS.Colors.tabBarUnselectTabColor
        tabBar.backgroundColor = DS.Colors.mainBackgroundColor
        
        let projects = ProjectsVC()
        let clients = ClientsVC()
        let main = MainVC()
        let courtCases = CourtCasesVC()
        let tasks = TasksVC()
        
        let projectsNavigationController = NavigationBarController(rootViewController: projects)
        let clientsNavigationController = NavigationBarController(rootViewController: clients)
        let mainNavigationController = NavigationBarController(rootViewController: main)
        let courtCasesNavigationController = NavigationBarController(rootViewController: courtCases)
        let tasksNavigationController = NavigationBarController(rootViewController: tasks)
        
        projectsNavigationController.tabBarItem = Tabs.projects.itemBar
        clientsNavigationController.tabBarItem = Tabs.clients.itemBar
        mainNavigationController.tabBarItem = Tabs.main.itemBar
        courtCasesNavigationController.tabBarItem = Tabs.courtCases.itemBar
        tasksNavigationController.tabBarItem = Tabs.tasks.itemBar
        
        setViewControllers([projectsNavigationController, clientsNavigationController, mainNavigationController, courtCasesNavigationController, tasksNavigationController], animated: false)
        
        selectedIndex = Tabs.main.rawValue
    }
}

extension NavigateTabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let haptic = UIImpactFeedbackGenerator(style: .light)
        haptic.impactOccurred()
    }
}
