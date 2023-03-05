//
//  TabBarViewController.swift
//  MyFitness
//
//  Created by Sachin on 3/5/23.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = HomeViewController()
        let vc2 = HomeViewController()
        let vc3 = HomeViewController()
        let vc4 = HomeViewController()
        
        vc1.navigationItem.largeTitleDisplayMode = .automatic
        vc2.navigationItem.largeTitleDisplayMode = .automatic
        vc3.navigationItem.largeTitleDisplayMode = .automatic
        vc4.navigationItem.largeTitleDisplayMode = .automatic
                
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        let nav4 = UINavigationController(rootViewController: vc4)
        
        nav1.tabBarItem = UITabBarItem(title: "Home",
                                       image: UIImage(systemName: "house"),
                                       tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Favourites",
                                       image: UIImage(systemName: "heart.circle.fill"),
                                       tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Profile",
                                       image: UIImage(systemName: "person.crop.circle"),
                                       tag: 3)
        nav4.tabBarItem = UITabBarItem(title: "Profile",
                                       image: UIImage(systemName: "person.crop.circle"),
                                       tag: 4)
        
        self.tabBar.tintColor = ColorGuide.primary
        
        for nav in [nav1, nav2, nav3, nav4]{
            nav.navigationBar.prefersLargeTitles = true
        }
            
        setViewControllers([nav1, nav2, nav3, nav4],
                           animated: false)
    }
}
