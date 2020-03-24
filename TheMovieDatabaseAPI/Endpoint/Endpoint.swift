//
//  Endpoint.swift
//  TheMovieDatabaseAPI
//
//  Created by Natali on 14.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation

public protocol Endpoint {
    
    associatedtype Content: Decodable
    
    var params: [String: Any]? { get }
     
    func makeRequest() throws -> URLRequest
    
    func content(from data: Data, response: URLResponse?) throws -> Content
}

extension Endpoint {
    
    var urlComponents: URLComponents {
        var components = URLComponents(string: "")!
        var queryItems = [URLQueryItem]()
        if let params = params {
            queryItems.append(contentsOf: params.map {
                let item = URLQueryItem(name: "\($0)", value: "\($1)")
                return item
            })
        }
        components.queryItems = queryItems
        return components
    }
    
    public func makeRequest() throws -> URLRequest {
        let url = urlComponents.url!
        let request = URLRequest(url: url)
        return request
    }
    
    public func content(from data: Data, response: URLResponse?) throws -> Content {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss zzz"
        decoder.dateDecodingStrategy = .formatted(formatter)
        return try decoder.decode(Content.self, from: data)
    }
}
