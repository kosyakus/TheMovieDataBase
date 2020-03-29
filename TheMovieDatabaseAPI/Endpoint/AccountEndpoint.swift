//
//  AccountEndpoint.swift
//  TheMovieDatabaseAPI
//
//  Created by Natali on 16.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation

public struct AccountEndpoint: Endpoint {
    
    public typealias Content = User
    
    public init() {}

    public func makeRequest() throws -> URLRequest {
        var request = URLRequest(url: URL(string: "account")!)
        request.httpMethod = "GET"
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
