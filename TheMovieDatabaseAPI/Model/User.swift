//
//  User.swift
//  TheMovieDatabase
//
//  Created by Natali on 09.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation

struct User: Codable {
    
    // MARK: - Public Properties
    
    var avatar: String
    var gravatar: NSObject
    let hash: String
    let id: Int
    let iso639: String
    let iso3166: String
    let name: String
    let isIncludeAdult: Bool
    let username: String
    
    /*enum UserKeys: String, CodingKey {
        case avatar
        case gravatar
        case hash
        case id
        case iso639 = "iso_639_1"
        case iso3166 = "iso_3166_1"
        case name
        case isIncludeAdult = "include_adult"
        case username
    }*/
    
    init?(json: [String: Any]) {

        guard
            let avatar = json["avatar"][0]["garavatar"][0][hash] as? String,
            let id = json["id"] as? Int,
            let iso639 = json["iso_639_1"] as? String,
            let iso3166 = json["iso_3166_1"] as? String,
            let name = json["name"] as? String,
            let isIncludeAdult = json["include_adult"] as? Bool,
            let username = json["username"] as? String
        else {
            return nil
        }

        self.avatar = avatar
        self.id = id
        self.iso639 = iso639
        self.iso3166 = iso3166
        self.name = name
        self.isIncludeAdult = isIncludeAdult
        self.username = username
    }

    
    /*required init(from decoder: Decoder) throws {
        let userContainer = try decoder.container(keyedBy: UserKeys.self)
        
        login = try userContainer.decode(String.self, forKey: .login)
        name = try userContainer.decode(String.self, forKey: .name)
        email = try userContainer.decode(String.self, forKey: .email)
        icon = try userContainer.decode(String.self, forKey: .icon)
    }*/

    static func getUser(from jsonArray: Any) -> User? {

        guard let jsonArray = jsonArray as? Array<[String: Any]> else { return nil }
        var user: User = User()

        for jsonObject in jsonArray {
            if let user = User(json: jsonObject) {
                user = user
            }
        }
        return user
    }
}
