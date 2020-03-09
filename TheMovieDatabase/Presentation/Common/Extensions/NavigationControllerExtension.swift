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
        //self.editButtonItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
        //self.editButtonItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .highlighted)
        
        //self.navigationBar.backItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        //self.navigationBar.backItem?.title = " "
    }
}

