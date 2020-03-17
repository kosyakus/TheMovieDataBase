//
//  Movie.swift
//  TheMovieDatabaseAPI
//
//  Created by Natali on 16.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation

public struct Movie: Codable {
    
    // MARK: - Public Properties
    
    public let id: Int
    public let title: String?
    public let originalTitle: String?
    public let averageVote: Double
    public let voteCount: Int?
    public let overview: String?
    public let posterPath: String?
    public let runtime: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case originalTitle = "original_title"
        case averageVote = "vote_average"
        case voteCount = "vote_count"
        case overview
        case posterPath = "poster_path"
        case runtime
    }
    
    public func getPoster() -> String {
        "https://image.tmdb.org/t/p/w185\(posterPath ?? "")"
    }
}
