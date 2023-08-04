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
        let vc2 = WorkoutPlanViewController()
        let vc3 = CustomScheduleViewController()
        
        vc1.navigationItem.largeTitleDisplayMode = .automatic
        vc2.navigationItem.largeTitleDisplayMode = .automatic
        vc3.navigationItem.largeTitleDisplayMode = .automatic
                
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        
        nav1.tabBarItem = UITabBarItem(title: "Excercises",
                                       image: UIImage(systemName: "dumbbell.fill"),
                                       tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Workouts Plan",
                                       image: UIImage(systemName: "list.bullet.clipboard.fill"),
                                       tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Custom Schedule",
                                       image: UIImage(systemName: "bookmark.fill"),
                                       tag: 3)
        
        self.tabBar.tintColor = ColorGuide.primary
        
        for nav in [nav1, nav2, nav3]{
            nav.navigationBar.prefersLargeTitles = true
        }
            
        setViewControllers([nav1, nav2, nav3],
                           animated: false)
    }
    
}
