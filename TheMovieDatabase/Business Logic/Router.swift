//
//  Router.swift
//  TheMovieDatabase
//
//  Created by Natali on 09.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    
    private var besePath: String {
        return "https://api.themoviedb.org/3/"
    }
    
    case getCreateRequestToken(api_key: String)
    
    private var path: String {
        switch self {
        case .getCreateRequestToken:
            return "authentication/token/new"
        }
    }
    
    private var method: HTTPMethod {
        switch self {
        case .getCreateRequestToken:
            return .get
        }
    }
    
    private var parameters: Parameters {
        switch self {
        case let .getCreateRequestToken(api_key):
            return ["api_key": api_key]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try besePath.asURL()
        let urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        return try URLEncoding.default.encode(urlRequest, with: parameters)
    
    }
}
