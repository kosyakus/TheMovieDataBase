//
//  KeychainUser.swift
//  TheMovieDatabase
//
//  Created by Natali on 16.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation

class KeychainUser: Codable {
    
    let username: String
    
    init(username: String) {
        self.username = username
    }
}
