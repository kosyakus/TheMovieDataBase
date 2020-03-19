//
//  UserSettings.swift
//  TheMovieDatabase
//
//  Created by Natali on 19.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation

@objc class UserSettings: NSObject {

    fileprivate let standartUserDefaults = UserDefaults.standard
    fileprivate let kBaseUrl = "baseUrl"
    
    let sharedDefaults = UserDefaults.standard
    static let shareInstance = UserSettings()
    
    fileprivate override init() {}
    
    var baseUrl: String {
        get {
            let value = sharedDefaults.object(forKey: kBaseUrl) != nil ? sharedDefaults.string(forKey: kBaseUrl) : "https://api.themoviedb.org/3/"
            return value!
        }
        set {
            sharedDefaults.set(newValue, forKey: kBaseUrl)
        }
    }
}
    
