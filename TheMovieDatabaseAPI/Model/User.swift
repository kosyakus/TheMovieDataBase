//
//  User.swift
//  TheMovieDatabaseAPI
//
//  Created by Natali on 16.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation

public struct User: Codable {
    
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

/*
extension User: Decodable {
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let user = try values.nestedContainer(keyedBy: UserKeys.self, forKey: .avatar)
        let gravatar = try user.decode([String: Data].self, forKey: .gravatar)
        print("gravatar \(gravatar.values)")
        if let data: Data = gravatar["hash"] {
            self.hash = data.base64EncodedString(options: NSData.Base64EncodingOptions())
        } else { self.hash = " " }
        self.id = try values.decode(Int.self, forKey: .id)
        self.iso639 = try values.decode(String.self, forKey: .iso639)
        self.iso3166 = try values.decode(String.self, forKey: .iso3166)
        self.name = try values.decode(String.self, forKey: .name)
        self.isIncludeAdult = try values.decode(Bool.self, forKey: .isIncludeAdult)
        self.username = try values.decode(String.self, forKey: .username)
    }
*/
