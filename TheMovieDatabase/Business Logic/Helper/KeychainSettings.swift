//
//  KeychainSettings.swift
//  TheMovieDatabase
//
//  Created by Natali on 11.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation

final class KeychainSettings {
    
    private enum Keys: String {
    case user = "current_user"
  }
  
  static var currentUser: User? {
    get {
      guard let data = UserDefaults.standard.data(forKey: Keys.user.rawValue) else {
        return nil
      }
      return try? JSONDecoder().decode(User.self, from: data)
    }
    set {
      if let data = try? JSONEncoder().encode(newValue) {
        UserDefaults.standard.set(data, forKey: Keys.user.rawValue)
      } else {
        UserDefaults.standard.removeObject(forKey: Keys.user.rawValue)
      }
      UserDefaults.standard.synchronize()
    }
  }
  
}
