//
//  MainTabBarController.swift
//  Podcasts
//
//  Created by sky on 1/9/22.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = .purple
        UINavigationBar.appearance().prefersLargeTitles = true
        
        setupViewControllers()
    }
    
    // MARK:- Setup Functions
    private func setupViewControllers() {
        viewControllers = [
            generateNavigationController(for: PodcastSearchController(), title: "Search", image: #imageLiteral(resourceName: "icSearch")),
            generateNavigationController(for: ViewController(), title: "Favorite", image: #imageLiteral(resourceName: "icFavorites")),
            generateNavigationController(for: ViewController(), title: "Downloads", image: #imageLiteral(resourceName: "icDownloads"))
        ]
    }
    
    // MARK:- Helper Functions
    
    fileprivate func generateNavigationController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
//        navController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
    }
}
