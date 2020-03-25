//
//  APIRequestAdapter.swift
//  TheMovieDatabaseAPI
//
//  Created by Natali on 21.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Alamofire
import Foundation

/// Адаптер запросов к API.
public final class APIRequestAdapter: Alamofire.RequestAdapter {

    /// Базовый `URL` API.
    public var baseURL: URL
    
    /// Ключ API.
    public var apiKey: String
    
    /// Сессия.
    // TODO: Подумать, может его стоит передавать как-то подругому
    public var sessionId: String?
    
    /// Создать адаптер с базовым `URL` и `apiKey`.
    ///
    /// - Parameter baseURL: Базовый `URL`
    init(baseURL: URL, apiKey: String, sessionId: String? = nil) {
        self.baseURL = baseURL
        self.apiKey = apiKey
        self.sessionId = sessionId
    }
    
    // MARK: - Alamofire.RequestAdapter
    
    public func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var request = urlRequest
        guard let requestPath = request.url?.path,
            var components = URLComponents(
                url: baseURL.appendingPathComponent(requestPath),
                resolvingAgainstBaseURL: true
            )
            else { return urlRequest }
        
        components.percentEncodedQuery = request.url?.query
        
        request.setValue(apiKey, forHTTPHeaderField: "api_key")
        let apiQueryItem = URLQueryItem(name: "api_key", value: apiKey)
        components.queryItems?.append(apiQueryItem)
        if let sessionId = sessionId {
            components.queryItems?.append(URLQueryItem(name: "session_id", value: sessionId))
        }
       
        request.url = components.url
        print("FINAL \(request)")
        return request
    }
}
