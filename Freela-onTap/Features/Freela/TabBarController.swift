//
//  TabBarController.swift
//  App-Challenge
//
//  Created by Ana Carolina Palhares Poletto on 11/06/25.
//

import UIKit

class TabBarController: UITabBarController {
    lazy var searchTab: UINavigationController = {
        let title = "Pesquisar"
        let image = UIImage(systemName: "text.page.badge.magnifyingglass")
        let tabItem = UITabBarItem(title: title, image: image, selectedImage: image)
        let rootViewController = JobListViewController()
        rootViewController.tabBarItem = tabItem
        rootViewController.title = "Descobrir"
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.navigationBar.prefersLargeTitles = true
        return navController
    }()
    
    lazy var exploreTab: UINavigationController = {
        let title = "Explorar"
        let image = UIImage(systemName: "safari")
        let tabItem = UITabBarItem(title: title, image: image, selectedImage: image)
        
        let rootViewController = UIViewController()
        rootViewController.tabBarItem = tabItem
        rootViewController.title = title
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.navigationBar.prefersLargeTitles = true
        return navController
    }()
    
    lazy var jobOppeningTab: UINavigationController = {
        let title = "Minhas Vagas"
        let image = UIImage(systemName: "calendar.badge.checkmark")
        let tabItem = UITabBarItem(title: title, image: image, selectedImage: image)
        let rootViewController = UIViewController()
        rootViewController.tabBarItem = tabItem
        rootViewController.title = title
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.navigationBar.prefersLargeTitles = true
        return navController
    }()
    
    lazy var profileTab: UINavigationController = {
        let title = "Perfil"
        let image = UIImage(systemName: "person")
        let tabItem = UITabBarItem(title: title, image: image, selectedImage: image)
        let rootViewController = UIViewController()
        rootViewController.tabBarItem = tabItem
        rootViewController.title = title
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.navigationBar.prefersLargeTitles = true
        return navController
    }()
    override func viewDidLoad() {
        viewControllers = [searchTab, exploreTab, jobOppeningTab, profileTab]
        tabBar.backgroundColor = .systemGray6
        super.viewDidLoad()
    }
}
