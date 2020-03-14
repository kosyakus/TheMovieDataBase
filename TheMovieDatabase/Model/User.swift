//
//  User.swift
//  TheMovieDatabase
//
//  Created by Natali on 09.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation

class User: Codable, Decodable {
    
    // MARK: - Public Properties
    
    let login: String
    let name: String
    let email: String
    let icon: String
    
    enum UserKeys: String, CodingKey {
        case login
        case name
        case email
        case icon
    }
    
    init(from decoder: Decoder) throws {
        let userContainer = try decoder.container(keyedBy: UserKeys.self)
        
        login = try userContainer.decode(String.self, forKey: .login)
        name = try userContainer.decode(String.self, forKey: .name)
        email = try userContainer.decode(String.self, forKey: .email)
        icon = try userContainer.decode(String.self, forKey: .icon)
    }
}
