//
//  AccountEndpoint.swift
//  TheMovieDatabaseAPI
//
//  Created by Natali on 16.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Alamofire
import Foundation

enum AccountEndpoint: URLRequestConvertible {
    
    case getAccountDetails(sessionId: String, apiKey: String)
    
    private var basePath: String {
        "https://api.themoviedb.org/3/"
    }
    
    private var path: String {
        switch self {
        case .getAccountDetails:
            return "account"
        }
    }
    
    private var method: HTTPMethod {
        switch self {
        case .getAccountDetails:
            return .get
        }
    }
    
    private var parameters: Parameters {
        switch self {
        case let .getAccountDetails(sessionId, apiKey):
        return ["session_id": sessionId, "api_key": apiKey]
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
        return try URLEncoding.queryString.encode(urlRequest, with: parameters)
        //URLEncoding.default.encode(urlRequest, with: parameters)
    }
}
