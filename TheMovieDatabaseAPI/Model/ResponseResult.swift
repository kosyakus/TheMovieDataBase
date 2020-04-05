//
//  DeletionResult.swift
//  TheMovieDatabaseAPI
//
//  Created by Natali on 16.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation

public struct ResponseResult: Codable {
    
    // MARK: - Public Properties
    
    public let success: Bool
}

public struct AddFavoriteMovieResult: Codable {
    
    // MARK: - Public Properties
    
    public let statusCode: Int
    public let statusMessage: String
}
