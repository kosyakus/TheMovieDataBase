//
//  TabBarController.swift
//  TheMovieDatabase
//
//  Created by Natali on 07.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    // MARK: - Private Properties
    
    private var bounceAnimation: CAKeyframeAnimation = {
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        bounceAnimation.values = [1.0, 1.4, 0.9, 1.02, 1.0]
        bounceAnimation.duration = TimeInterval(0.3)
        bounceAnimation.calculationMode = CAAnimationCalculationMode.cubic
        return bounceAnimation
    }()

    // MARK: - TabBarController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTabBar()
        self.tabBar.barTintColor = UIColor.CustomColor.darkBlue
        navigationController?.navigationBar.barTintColor = UIColor.CustomColor.bgBlack
    }
    
    /// Анимация при нажатии кнопок TabBar'а
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        // find index if the selected tab bar item, then find the corresponding view and get its image, the view position is offset by 1 because the first item is the background (at least in this case)
        guard let idx = tabBar.items?.firstIndex(of: item),
            tabBar.subviews.count > idx + 1,
            let imageView = tabBar.subviews[idx + 1].subviews.compactMap({ $0 as? UIImageView }).first else {
            return
        }

        // animate the imageView
        imageView.layer.add(bounceAnimation, forKey: nil)
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
        viewControllers = tabBarList.map { UINavigationController(rootViewController: $0, isTranslucent: false) }

        UITabBar.appearance().tintColor = UIColor.CustomColor.orange
    }
}
