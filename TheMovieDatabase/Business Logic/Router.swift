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
    case getCreateRequestToken(apiKey: String)
    case postValidateToken(username: String, password: String, requestToken: String, apiKey: String)
    case postCreateSession(requestToken: String, apiKey: String)
    case deleteSession(sessionId: String, apiKey: String)
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
        case let .getCreateRequestToken(apiKey):
            return ["api_key": apiKey]
        case let .postValidateToken(username, password, requestToken, apiKey):
            return ["username": username, "password": password, "request_token": requestToken, "api_key": apiKey]
        case let .postCreateSession(requestToken, apiKey):
            return ["request_token": requestToken, "api_key": apiKey]
        case let .deleteSession(sessionId, apiKey):
            return ["session_id": sessionId, "api_key": apiKey]
        }
    }
    func asURLRequest() throws -> URLRequest {
        let url = try besePath.asURL()
        let urlRequest = URLRequest(url: url.appendingPathComponent(path))
        return try URLEncoding.default.encode(urlRequest, with: parameters)
    }
}
