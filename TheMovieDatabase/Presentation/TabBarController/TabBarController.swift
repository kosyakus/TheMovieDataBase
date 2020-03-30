//
//  TabBarController.swift
//  TheMovieDatabase
//
//  Created by Natali on 07.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTabBar()
        self.tabBar.barTintColor = UIColor.CustomColor.darkBlue
        navigationController?.navigationBar.barTintColor = UIColor.CustomColor.bgBlack
    }

    // MARK: - Public methods
    func setUpTabBar() {
        let firstViewController = MainViewController()
        firstViewController.tabBarItem = UITabBarItem(
        title: "Фильмы",
        image: #imageLiteral(resourceName: "movie_tabbar_icon"),
        tag: 0)

        let secondViewController = FavoriveViewController()
        secondViewController.tabBarItem = UITabBarItem(
        title: "Избранное",
        image: #imageLiteral(resourceName: "favorite_tabbar_icon"),
        tag: 1)
        
        let thirdViewController = ProfileViewController()
        thirdViewController.tabBarItem = UITabBarItem(
        title: "Профиль",
        image: #imageLiteral(resourceName: "account_tabbar_icon"),
        tag: 2)

        let tabBarList = [firstViewController, secondViewController, thirdViewController]

        viewControllers = tabBarList
        UITabBar.appearance().tintColor = UIColor.CustomColor.orange
    }
}
