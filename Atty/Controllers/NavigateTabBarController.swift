//
//  NavigateTabBarController.swift
//  Atty
//
//  Created by Nikita Melnikov on 26.10.2023.
//

import Foundation
import UIKit

class NavigateTabBarController: UITabBarController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupView()
        self.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension NavigateTabBarController {
    
    func setupView() {
        tabBar.tintColor = DS.Colors.standartTextColor
        tabBar.barTintColor = DS.Colors.tabBarUnselectTabColor
        tabBar.backgroundColor = DS.Colors.mainBackgroundColor
        
        let projects = ProjectsVC()
        let clients = ClientsVC()
        let main = MainVC()
        let courtCases = CourtCasesVC()
        let tasks = TasksVC()
        
        let projectsNavigationController = UINavigationController(rootViewController: projects)
        let clientsNavigationController = UINavigationController(rootViewController: clients)
        let mainNavigationController = UINavigationController(rootViewController: main)
        let courtCasesNavigationController = UINavigationController(rootViewController: courtCases)
        let tasksNavigationController = UINavigationController(rootViewController: tasks)
        
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
