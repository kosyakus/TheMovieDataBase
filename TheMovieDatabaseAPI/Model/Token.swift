//
//  Token.swift
//  TheMovieDatabaseAPI
//
//  Created by Natali on 15.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation

public struct Token: Codable {
    
    // MARK: - Public Properties
    
    public let requestToken: String
    
    enum CodingKeys: String, CodingKey {
        case requestToken = "request_token"
    }
}
