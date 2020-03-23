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
                url: baseURL, //.appendingPathComponent(requestPath),
                resolvingAgainstBaseURL: true
            )
            else { return urlRequest }

        request.setValue(apiKey, forHTTPHeaderField: "api_key")
        var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        if let sessionId = sessionId {
            queryItems.append(URLQueryItem(name: "session_id", value: sessionId))
        }
        components.queryItems = queryItems

        request.url = components.url!.appendingPathComponent(requestPath)
        print("FINAL \(request)")
        return request
    }
    
//    public func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
//        guard let url = urlRequest.url else { return urlRequest }
//
//        var request = urlRequest
//        request.url = appendingBaseURL(to: url)
//
//        request.setValue(apiKey, forHTTPHeaderField: "api_key")
//
//        return request
//    }
//
//    private func appendingBaseURL(to url: URL) -> URL {
//        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
//        components.percentEncodedQuery = url.query
//        var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
//        if let sessionId = sessionId {
//            queryItems.append(URLQueryItem(name: "session_id", value: sessionId))
//        }
//        components.queryItems = queryItems
//
//        return components.url!.appendingPathComponent(url.path)
//    }
}
