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
    
    public let genres: [String]
    public let runtime: Int?
    
    enum UserKeys: String, CodingKey {
        case name
    }
    
    enum CodingKeys: String, CodingKey {
        case genres
        case runtime
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let genres = try values.nestedContainer(keyedBy: UserKeys.self, forKey: .genres)
        let array = try genres.decode([String].self, forKey: .name)
        
        print("Genres \(array)")
        self.genres = array
        runtime = try values.decode(Int.self, forKey: .runtime)
    }
    
}
