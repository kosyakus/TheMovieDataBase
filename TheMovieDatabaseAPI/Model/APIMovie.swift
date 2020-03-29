//
//  Movie.swift
//  TheMovieDatabaseAPI
//
//  Created by Natali on 16.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation

public struct APIMovie: Decodable {
    
    // MARK: - Public Properties
    
    public let id: Int
    public let title: String?
    public let originalTitle: String?
    public let voteAverage: Double
    public let voteCount: Int?
    public let overview: String?
    public let posterPath: String?
    public let runtime: Int?

//    public func getPoster() -> String {
//        "https://image.tmdb.org/t/p/w185\(posterPath ?? "")"
//    }
}
