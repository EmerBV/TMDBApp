//
//  TMDBMainTabBarViewController.swift
//  TMDBApp
//
//  Created by Emerson Balahan Varona on 16/9/23.
//

import UIKit

final class TMDBMainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpTabs()
    }
    
    private func setUpTabs() {
        let vc1 = UINavigationController(rootViewController: TMDBHomeViewController())
        let vc2 = UINavigationController(rootViewController: TMDBUpcomingViewController())
        let vc3 = UINavigationController(rootViewController: TMDBSearchViewController())
        let vc4 = UINavigationController(rootViewController: TMDBDownloadsViewController())
        
        vc1.tabBarItem.image = UIImage(systemName: "house.circle")
        vc2.tabBarItem.image = UIImage(systemName: "play.circle")
        vc3.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vc4.tabBarItem.image = UIImage(systemName: "arrow.down.circle")
        
        vc1.title = "Home"
        vc2.title = "Coming Soon"
        vc3.title = "Top Search"
        vc4.title = "Downloads"
        
        tabBar.tintColor = .label
        
        setViewControllers([vc1, vc2, vc3, vc4], animated: true)
    }

}
