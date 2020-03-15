//
//  UserEndpoint.swift
//  TheMovieDatabaseAPI
//
//  Created by Natali on 14.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Alamofire
import Foundation

enum UserEndpoint: APIConfiguration {
    
    case getCreateRequestToken(apiKey: String)
    case postValidateToken(username: String, password: String, requestToken: String, apiKey: String)
    case postCreateSession(requestToken: String, apiKey: String)
    case deleteSession(sessionId: String, apiKey: String)
 
    // MARK: - HTTPMethod
    
    var method: HTTPMethod {
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
    
    // MARK: - Path
    
    var path: String {
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
    
    // MARK: - Parameters
    
    var parameters: Parameters? {
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
    
    // MARK: - URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.ProductionServer.baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(Constants.ContentType.json.rawValue,
                            forHTTPHeaderField: Constants.HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(Constants.ContentType.json.rawValue,
                            forHTTPHeaderField: Constants.HTTPHeaderField.contentType.rawValue)
 
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        return urlRequest
    }
}
