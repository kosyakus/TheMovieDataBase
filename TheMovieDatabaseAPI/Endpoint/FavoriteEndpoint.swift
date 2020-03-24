//
//  FavoriteEndpoint.swift
//  TheMovieDatabaseAPI
//
//  Created by Natali on 17.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Alamofire
import Foundation

public struct FavoriteEndpoint: Endpoint {
    
    public typealias Content = Movies
    
    private let accountId: String
    public var params: [String : Any]?
    
    public init(accountId: String) {
        self.accountId = accountId
    }
    
    public func makeRequest() throws -> URLRequest {
        var request = URLRequest(url: URL(string: "account/\(accountId)/favorite/movies")!)
        request.httpMethod = "GET"
        return request
    }
    
    public func content(from data: Data, response: URLResponse?) throws -> Content {
        
        // TODO: Вынести общие данные в базовый Endpoint
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss zzz"
        decoder.dateDecodingStrategy = .formatted(formatter)
        return try decoder.decode(Content.self, from: data)
    }
}
