//
//  Movie.swift
//  TheMovieDatabaseAPI
//
//  Created by Natali on 16.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation

public struct Movies: Decodable {
    
    // MARK: - Public Properties
    
    public let results: [APIMovie]
    
//    enum CodingKeys: String, CodingKey {
//        case results
//    }
}

// image path http://image.tmdb.org/t/p/w185/Av40pxbR5LPeCCNnqw4gHh4TtSP.jpg
