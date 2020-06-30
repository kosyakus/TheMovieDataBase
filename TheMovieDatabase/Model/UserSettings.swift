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
    static let shareInstance = UserSettings()
    fileprivate override init() {}

    fileprivate let kAccountID = "accountID"
    fileprivate let kDataBase = "dataBase"
    fileprivate let kIsPinCreated = "isPinCreated"
    
    var accountID: String {
        get {
            let value = standartUserDefaults.object(forKey: kAccountID) != nil ?
                standartUserDefaults.string(forKey: kAccountID) : ""
            return value!
        }
        set {
            standartUserDefaults.set(newValue, forKey: kAccountID)
        }
    }
    
    var dataBase: Int {
        get {
            let value = standartUserDefaults.object(forKey: kDataBase) != nil ?
                standartUserDefaults.integer(forKey: kDataBase) : 0
            return value
        }
        set {
            standartUserDefaults.set(newValue, forKey: kDataBase)
        }
    }
    
    var isPinCreated: Bool {
        get {
            let value = standartUserDefaults.object(forKey: kIsPinCreated) != nil ?
                standartUserDefaults.bool(forKey: kIsPinCreated) : false
            return value
        }
        set {
            standartUserDefaults.set(newValue, forKey: kIsPinCreated)
        }
    }
}
    
