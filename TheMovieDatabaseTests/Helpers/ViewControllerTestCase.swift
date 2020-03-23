//
//  ViewControllerTestCase.swift
//  TheMovieDatabaseTests
//
//  Created by Natali on 22.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import XCTest

class ViewControllerTestCase: XCTestCase {
    
    lazy var window: UIWindow = { UIWindow(frame: UIScreen.main.bounds) }()

    var rootViewController: UIViewController? {
        get {
            return window.rootViewController
        }
        set {
            window.rootViewController = newValue
        }
    }
    
    override func setUp() {
        if !window.isKeyWindow {
            window.makeKeyAndVisible()
        }
    }
    
    func subview<T: UIView>(with identifier: String) -> T? {
        rootViewController?.view.subview(withAccessibilityIdentifier: identifier)
    }
}
