//
//  SearchMoviesEndpoint.swift
//  TheMovieDatabaseAPI
//
//  Created by Natali on 16.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Alamofire
import Foundation

public struct SearchMoviesEndpoint: Endpoint {
    
    public typealias Content = Movies

    private let language: String
    private let query: String
    
    public init(language: String?, query: String) {
        self.query = query
        guard let lang = language else {
            self.language = Locale.current.languageCode!
            //self.parameters = ["language": self.language, "query": query]
            return
        }
        self.language = lang
        //self.parameters = ["language": self.language, "query": query]
    }
    //private var parameters: Parameters
    
    public func makeRequest() throws -> URLRequest {
        var urlComp = URLComponents(url: URL(string: "search/movie")!, resolvingAgainstBaseURL: true)!
        let dict = ["language": self.language, "query": query]
        urlComp.setQueryItems(with: dict)
        //let queryItem = URLQueryItem(name: "query", value: query)
        //var request = URLComponents(url: URL(string: "search/movie")!, resolvingAgainstBaseURL: true)
        var request = URLRequest(url: URL(string: "search/movie")!)
        request.url = urlComp.url
//        let encoder = JSONEncoder()
//        request.httpBody = try encoder.encode(self)
        
        request.httpMethod = "GET"
        
        //request = try URLEncoding.queryString.encode(request, with: ["language": self.language, "query": query])
        print(request)
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

extension URLComponents {
    
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
    
}
