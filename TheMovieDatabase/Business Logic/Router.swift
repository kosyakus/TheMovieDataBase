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
    case postValidateToken(username: String, password: String, request_token: String,api_key: String)
    case postCreateSession(request_token: String, api_key: String)
    case deleteSession(sessionId: String, api_key: String)
    
    private var path: String {
        switch self {
        case .getCreateRequestToken:
            return "authentication/token/new"
        case .postValidateToken:
            return "authentication/token/validate_with_login"
        case .postCreateSession:
            return "authentication/session/new"
        case .deleteSession:
            return "authentication/session"
        }
    }
    
    private var method: HTTPMethod {
        switch self {
        case .getCreateRequestToken:
            return .get
        case .postValidateToken:
            return .post
        case .postCreateSession:
            return .post
        case .deleteSession:
            return .delete
        }
    }
    
    private var parameters: Parameters {
        switch self {
        case let .getCreateRequestToken(api_key):
            return ["api_key": api_key]
        case let .postValidateToken(username, password, request_token, api_key):
            return ["username": username, "password": password, "request_token": request_token, "api_key": api_key]
        case let .postCreateSession(request_token, api_key):
            return ["request_token": request_token, "api_key": api_key]
        case let .deleteSession(sessionId, api_key):
            return ["session_id": sessionId, "api_key": api_key]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try besePath.asURL()
        let urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        return try URLEncoding.default.encode(urlRequest, with: parameters)
    
    }
}
