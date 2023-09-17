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
        setUpTabs()
    }
    
    private func setUpTabs() {
        let vc1 = UINavigationController(rootViewController: TMDBHomeViewController())
        
        vc1.tabBarItem.image = UIImage(systemName: "house.circle")
        vc1.title = "Home"
        
        tabBar.tintColor = .white
        
        setViewControllers([vc1], animated: true)
    }
}
