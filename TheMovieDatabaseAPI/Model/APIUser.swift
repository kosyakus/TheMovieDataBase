//
//  User.swift
//  TheMovieDatabaseAPI
//
//  Created by Natali on 16.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation

public struct APIUser: Codable {
    
    // MARK: - Public Properties
    
    public let avatar: Gravatar
    public let id: Int
    public let iso6391: String
    public let iso31661: String
    public let name: String
    public let includeAdult: Bool
    public let username: String
}

public struct Gravatar: Codable {
    
    // MARK: - Public Properties
    
    public let gravatar: Hash
}

public struct Hash: Codable {
    
    // MARK: - Public Properties
    
    public let hash: String
}
