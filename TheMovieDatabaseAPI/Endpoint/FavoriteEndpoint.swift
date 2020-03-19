//
//  FavoriteEndpoint.swift
//  TheMovieDatabaseAPI
//
//  Created by Natali on 17.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Alamofire
import Foundation

enum FavoriteEndpoint: URLRequestConvertible {
    
    case getFavoriteList(session: String, apiKey: String)
    
    private var basePath: String {
        UserDefaults.standard.string(forKey: "kBaseUrl") ?? "https://api.themoviedb.org/3/"
    }
    
    private var path: String {
        switch self {
        case .getFavoriteList:
            return "account/{account_id}/favorite/movies"
        }
    }
    
    private var method: HTTPMethod {
        switch self {
        case .getFavoriteList:
            return .get
        }
    }
    
    private var parameters: Parameters {
        switch self {
        case let .getFavoriteList(session, apiKey):
            return ["session_id": session, "api_key": apiKey]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try basePath.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        // Common Headers
        urlRequest.setValue(Constants.ProductionServer.apiKey,
                            forHTTPHeaderField: Constants.HTTPHeaderField.authentication.rawValue)
        return try URLEncoding.default.encode(urlRequest, with: parameters)
            //URLEncoding.queryString.encode(urlRequest, with: parameters)
    }
}
