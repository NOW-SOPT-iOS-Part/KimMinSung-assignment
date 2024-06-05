//
//  UITabBarConExtensions.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/04/26.
//

import UIKit

extension UITabBarController {
    
    
    static func getMainTabBarCon() -> UITabBarController {
        
        let tabBarCon = UITabBarController()
        //let homeNaviCon = UINavigationController(rootViewController: HomeViewController())
        let homeNaviCon = UINavigationController(rootViewController: HomeTabViewController())
        
        tabBarCon.setViewControllers([
                homeNaviCon,
                UpcomingContentsViewController(),
                SearchingViewController(),
                HistoryViewController()
            ],
            animated: false
        )
        tabBarCon.tabBar.items?[0].image = .init(systemName: "house")
        tabBarCon.tabBar.items?[0].title = "홈"
        tabBarCon.tabBar.items?[1].image = .init(systemName: "play.rectangle.on.rectangle")
        tabBarCon.tabBar.items?[1].title = "공개예정"
        tabBarCon.tabBar.items?[2].image = .init(systemName: "magnifyingglass")
        tabBarCon.tabBar.items?[2].title = "검색"
        tabBarCon.tabBar.items?[3].image = .init(systemName: "clock")
        tabBarCon.tabBar.items?[3].title = "기록"
        tabBarCon.tabBar.backgroundColor = .black
        tabBarCon.tabBar.tintColor = .white
        tabBarCon.tabBar.unselectedItemTintColor = .gray3
        let standardAppearance = UITabBarAppearance()
        standardAppearance.configureWithDefaultBackground()
        standardAppearance.backgroundColor = .black
        tabBarCon.tabBar.standardAppearance = standardAppearance
        return tabBarCon
    }
    
}
