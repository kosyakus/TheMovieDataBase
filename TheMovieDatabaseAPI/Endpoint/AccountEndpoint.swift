//
//  AccountEndpoint.swift
//  TheMovieDatabaseAPI
//
//  Created by Natali on 16.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation

public struct AccountEndpoint: Endpoint {
    
    public typealias Content = APIUser
    private let session: String
    private var params: [String: String]
    
    public init(session: String) {
        self.session = session
        self.params = ["session_id": session]
    }
    
    public func makeRequest() throws -> URLRequest {
        var urlComp = URLComponents(string: "account")!
        urlComp.setQueryItems(with: params)
        
        var request = URLRequest(url: URL(string: "account")!)
        request.url = urlComp.url
        request.httpMethod = "GET"
        return request
    }

//    public func makeRequest() throws -> URLRequest {
//        var request = URLRequest(url: URL(string: "account")!)
//        request.httpMethod = "GET"
//        return request
//    }
    
    public func content(from data: Data, response: URLResponse?) throws -> Content {
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss zzz"
        decoder.dateDecodingStrategy = .formatted(formatter)
        return try decoder.decode(Content.self, from: data)
    }
}
