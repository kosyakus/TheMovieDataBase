//
//  AppDelegate.swift
//  TheMovieDatabase
//
//  Created by Natali on 05.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var navigationController: UINavigationController?
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        presentViewController()
        return true
    }
    // MARK: - Public methods
    func presentViewController() {
        if let window = window {
            var mainVC = UIViewController()
            if isUserExist() {
                mainVC = TabBarController()
            } else {
                mainVC = LoginViewController()
            }
            navigationController = UINavigationController(rootViewController: mainVC, isTranslucent: false)
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
    }
    // MARK: - Private Methods
    private func isUserExist() -> Bool {
        do {
            let realm = try Realm()
            let user = realm.objects(User.self)
            //print("User \(user)")
            guard !user.isEmpty else { return false }
            return true
        } catch {
            print(error)
        }
        return false
    }
}
