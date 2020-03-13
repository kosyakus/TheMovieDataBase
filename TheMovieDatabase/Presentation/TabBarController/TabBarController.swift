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
        self.tabBar.barTintColor = UIColor(named: "DarkBlue")
        navigationController?.navigationBar.barTintColor = UIColor(named: "Bg_black")
    }

    // MARK: - Public methods
    func setUpTabBar() {
        let firstViewController = MainViewController()
        firstViewController.tabBarItem = UITabBarItem(
        title: "Фильмы",
        image: UIImage(named: "movie_tabbar_icon"),
        tag: 0)

        let secondViewController = FavoriveViewController()

        secondViewController.tabBarItem = UITabBarItem(
        title: "Избранное",
        image: UIImage(named: "favorite_tabbar_icon"),
        tag: 1)
        let thirdViewController = ProfileViewController()

        thirdViewController.tabBarItem = UITabBarItem(
        title: "Профиль",
        image: UIImage(named: "account_tabbar_icon"),
        tag: 2)

        let tabBarList = [firstViewController, secondViewController, thirdViewController]

        viewControllers = tabBarList
        UITabBar.appearance().tintColor = UIColor(named: "Orange")
    }
}
