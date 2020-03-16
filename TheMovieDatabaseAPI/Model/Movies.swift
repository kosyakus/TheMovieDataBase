//
//  Movie.swift
//  TheMovieDatabaseAPI
//
//  Created by Natali on 16.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation

public struct Movies {
    
    // MARK: - Public Properties
    
    public let id: Int
    public let title: String?
//    public let originalTitle: String?
//    public let averageVote: NSNumber?
//    public let voteCount: Int?
//    public let overview: String?
//    public let poster: String?
    
    enum UserKeys: String, CodingKey {
        case id
        case title
//        case originalTitle = "original_title"
//        case averageVote = "vote_average"
//        case voteCount = "vote_count"
//        case poster
       }
    
    enum CodingKeys: String, CodingKey {
        case results
//        case id
//        case title
//        case originalTitle = "original_title"
//        case averageVote = "vote_average"
//        case voteCount = "vote_count"
//        case poster = "overview"
//        case poster = "poster_path"
    }
}

extension Movies: Decodable {
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let movies = try values.nestedContainer(keyedBy: UserKeys.self, forKey: .results)
        id = try movies.decode(Int.self, forKey: .id)
        title = try movies.decode(String.self, forKey: .title)
        
        //print("ID \(id), title \(title)")
        
    }
}

// image path http://image.tmdb.org/t/p/w185/Av40pxbR5LPeCCNnqw4gHh4TtSP.jpg
