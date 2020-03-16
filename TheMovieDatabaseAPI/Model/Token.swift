//
//  Token.swift
//  TheMovieDatabaseAPI
//
//  Created by Natali on 15.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation

public struct Token: Codable {
    
    // MARK: - Public Properties
    
    public let token: String
    
    enum CodingKeys: String, CodingKey {
        case token = "request_token"
    }
}

//    init?(json: [String: Any]) {
//
//        guard
//            let token = json["request_token"] as? String
//        else {
//            return nil
//        }
//
//        self.token = token
//    }
//
//    static func getToken(from jsonArray: Any) -> Token? {
//
//        guard let jsonArray = jsonArray as? Array<[String: Any]> else { return nil }
//        var token: Token = Token()
//
//        for jsonObject in jsonArray {
//            if let sess = Token(json: jsonObject) {
//                token = sess
//            }
//        }
//        return token
//    }
//}
