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
    
    func makeRequest() throws -> URLRequest
    
    func content(from data: Data, response: URLResponse?) throws -> Content
}

extension Endpoint {
    func content(from data: Data, response: URLResponse?) throws -> Content {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss zzz"
        decoder.dateDecodingStrategy = .formatted(formatter)
        return try decoder.decode(Content.self, from: data)
    }
}
