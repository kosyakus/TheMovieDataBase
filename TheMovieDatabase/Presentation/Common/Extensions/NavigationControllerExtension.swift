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
    
    //    func initRootViewController(vc: UIViewController,
    //                                transitionType type: CATransitionType = CATransitionType.fade,
    //                                duration: CFTimeInterval = 0.3) {
    //        self.addTransition(transitionType: type, duration: duration)
    //        setNavBar()
    //        self.viewControllers.removeAll()
    //        self.pushViewController(vc, animated: false)
    //        self.popToRootViewController(animated: false)
    //    }
    
    
    //    private func addTransition(transitionType type: CATransitionType = CATransitionType.fade,
    //                               duration: CFTimeInterval = 0.3) {
    //        let transition = CATransition()
    //        transition.duration = duration
    //        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    //        transition.type = type
    //        self.view.layer.add(transition, forKey: nil)
    //    }
}
