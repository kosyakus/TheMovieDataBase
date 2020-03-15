//
//  Session.swift
//  TheMovieDatabaseAPI
//
//  Created by Natali on 14.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation

public struct Session: Codable {
    
    // MARK: - Public Properties
    
    public let sessionId: String
    
    enum CodingKeys: String, CodingKey {
        case sessionId = "session_id"
    }
}
