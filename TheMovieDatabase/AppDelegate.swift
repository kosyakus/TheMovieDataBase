//
//  AppDelegate.swift
//  TheMovieDatabase
//
//  Created by Natali on 05.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Public Properties
    
    var window: UIWindow?
    var navigationController: UINavigationController?
    var isSignedIn: Bool {
        guard KeychainSettings.currentUser != nil else { return false }
        return true
    }
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        presentViewController(fromPinVC: false)
        return true
    }
    
    // MARK: - Public methods
    
    func addObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(presentViewController),
            name: .loginStatusChanged,
            object: nil
        )
    }
    
    @objc func presentViewController(fromPinVC: Bool) {
        
        if let window = window {
            var mainVC = UIViewController()
            if isSignedIn {
                mainVC = MakePinViewController()
                
                UIView.transition(with: self.window!,
                                  duration: 0.5,
                                  options: .transitionFlipFromLeft,
                                  animations: {
                    self.window?.rootViewController = mainVC
                })
            } else {
                mainVC = LoginViewController()
                navigationController = UINavigationController(rootViewController: mainVC, isTranslucent: false)
                window.rootViewController = navigationController
            }
            if fromPinVC {
                mainVC = TabBarController()
                window.rootViewController = mainVC
            }
            window.makeKeyAndVisible()
        }
    }
    
}
