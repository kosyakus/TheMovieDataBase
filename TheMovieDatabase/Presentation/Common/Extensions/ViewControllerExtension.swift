//
//  ViewControllerExtension.swift
//  TheMovieDatabase
//
//  Created by Natali on 07.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                 action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIViewController {
    
    func addContainerView(_ viewController: UIViewController) {
        self.addChild(viewController)
        viewController.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
//        let constraint: [NSLayoutConstraint] = [
//            viewController.view.topAnchor.constraint(
//                equalTo: view.topAnchor, constant: 100),
//            viewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            viewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            viewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ]
//        NSLayoutConstraint.activate(constraint)
        viewController.view.frame = CGRect(x: 0, y: view.frame.origin.y + 60,
                                           width: view.frame.width, height: view.frame.height - 60)
        self.view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
    
    func removeContainerView(_ viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParent: nil)
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        // Notify Child View Controller
        viewController.removeFromParent()
    }
    
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func remove() {
        // Just to be safe, we check that this view controller
        // is actually added to a parent before removing it.
        guard parent != nil else {
            return
        }

        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
