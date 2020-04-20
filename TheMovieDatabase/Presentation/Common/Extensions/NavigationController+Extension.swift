//
//  NavigationControllerExtension.swift
//  TheMovieDatabase
//
//  Created by Natali on 08.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    convenience init(rootViewController: UIViewController, isTranslucent: Bool) {
        self.init(rootViewController: rootViewController)
        setNavBar()
    }
    
    private func setNavBar() {
        self.navigationBar.barTintColor = UIColor.CustomColor.bgBlack
        self.navigationBar.isTranslucent = false
        self.navigationBar.tintColor = UIColor.CustomColor.light
        self.navigationBar.setValue(true, forKey: "hidesShadow")
    }
}
