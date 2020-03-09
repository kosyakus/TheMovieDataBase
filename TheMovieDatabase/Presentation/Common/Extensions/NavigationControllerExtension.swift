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
    convenience init(rootViewController: UIViewController,isTranslucent: Bool) {
        self.init(rootViewController: rootViewController)
        self.navigationBar.barTintColor = UIColor(named: "Bg_black")
        self.navigationBar.isTranslucent = false
        self.navigationBar.tintColor = UIColor(named: "Light")
        self.navigationBar.setValue(true, forKey: "hidesShadow")
    }
}

