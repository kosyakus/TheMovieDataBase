//
//  Error.swift
//  TheMovieDatabaseAPI
//
//  Created by Natali on 17.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation

public struct Errors: Codable {
    
    // MARK: - Public Properties
    
    public let statusCode: Int
    public let errorMessage: String
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case errorMessage = "status_message"
    }
}
