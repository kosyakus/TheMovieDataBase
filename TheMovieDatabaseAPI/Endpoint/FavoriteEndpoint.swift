//
//  FavoriteEndpoint.swift
//  TheMovieDatabaseAPI
//
//  Created by Natali on 17.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation

public struct FavoriteEndpoint: Endpoint {
    
    public typealias Content = Movies
    
    private let accountId: String
    private let session: String
    private var params: [String: String]
    
    public init(session: String, accountId: String) {
        self.accountId = accountId
        self.session = session
        self.params = ["session_id": session]
    }
    
    public func makeRequest() throws -> URLRequest {
        var urlComp = URLComponents(string: "account/\(accountId)/favorite/movies")!
        urlComp.setQueryItems(with: params)
        
        var request = URLRequest(url: URL(string: "account/\(accountId)/favorite/movies")!)
        request.url = urlComp.url
        
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
