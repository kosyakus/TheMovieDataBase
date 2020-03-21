//
//  APIRequestAdapter.swift
//  TheMovieDatabaseAPI
//
//  Created by Natali on 20.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Alamofire
import Foundation

/// Адаптер запросов к апи

//public final class APIRequestAdapter: Alamofire.RequestAdapter {
//    
//    /// Базовый URL API
//    public var baseURL: URL
//    
//    /// api_key
//    public var apiKey: String?
//    
//    /// Адаптер с базовым URL
//    init(baseURL: URL) {
//        self.baseURL = baseURL
//    }
//    
//    // MARK: - Alamofire.RequestAdapter
//    
//    public func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
//        guard let url = urlRequest.url else { return urlRequest }
//        
//        var request = urlRequest
//        request.url = appendingBaseURL(to: url)
//        
//        if let apiKey = apiKey {
//            request.setValue("API key \(apiKey)", forHTTPHeaderField: "Authentication")
//        }
//        return request
//    }
//    
//    // MARK: - Private
//    
//    private func appendingBaseURL(to url: URL) -> URL {
//        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
//        components.percentEncodedQuery = url.query
//        return components.url!.appendingPathComponent(url.path)
//    }
//}
