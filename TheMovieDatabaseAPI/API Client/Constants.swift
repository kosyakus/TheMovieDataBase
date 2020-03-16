//
//  Constants.swift
//  TheMovieDatabaseAPI
//
//  Created by Natali on 14.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation

struct Constants {
    
    struct ProductionServer {
        static let baseURL = "https://api.themoviedb.org/3/"
        static let apiKey = "93a57d2565c91c4db19ce6040806f41b"
    }
    
    enum HTTPHeaderField: String {
        case authentication = "api_key"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }
    
    enum ContentType: String {
        case json = "application/json"
    }
}
