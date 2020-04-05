//
//  AddMovieToFavoriteEndpoint.swift
//  TheMovieDatabaseAPI
//
//  Created by Natali on 05.04.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation

public struct AddMovieToFavoriteEndpoint: Endpoint {
    
    public typealias Content = AddFavoriteMovieResult
    
    private let accountId: String
    private let movieId: Int
    private var params: [String: Any]
    
    public init(accountId: String, movieId: Int) {
        self.accountId = accountId
        self.movieId = movieId
        self.params = ["media_type": "movie", "media_id": movieId, "favorite": true]
    }
    
    public func makeRequest() throws -> URLRequest {
        var request = URLRequest(url: URL(string: "account/\(accountId)/favorite")!)
        request.httpBody = self.params.percentEncode()
        request.httpMethod = "POST"
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
