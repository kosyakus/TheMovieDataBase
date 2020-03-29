//
//  DeleteSessionEndpoint.swift
//  TheMovieDatabaseAPI
//
//  Created by Natali on 29.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation

public struct DeleteSessionEndpoint: Endpoint, Codable {
    
    public typealias Content = ResponseResult

    private let session: String
    private var params: [String: String]
    
    public init(session: String) {
        self.session = session
        self.params = ["session_id": session]
    }
    
    public func makeRequest() throws -> URLRequest {
        var request = URLRequest(url: URL(string: "authentication/session")!)
        request.httpBody = self.params.percentEncode()
        request.httpMethod = "DELETE"
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
