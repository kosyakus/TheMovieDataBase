//
//  SearchMoviesEndpoint.swift
//  TheMovieDatabaseAPI
//
//  Created by Natali on 16.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Alamofire
import Foundation

public struct SearchMoviesEndpoint: Endpoint, Encodable {
    
    public typealias Content = [APIMovie]

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
    //private var parameters: [String: Any]?
    
    public func makeRequest() throws -> URLRequest {
//        if let params = parameters {
//            queryItems.append(contentsOf: params.map {
//                let item = URLQueryItem(name: "\($0)", value: "\($1)")
//                return item
//            })
//        }
        
        var urlComp = URLComponents(string: "search/movie")!
        let queryItem = [URLQueryItem(name: "query", value: query),
                         URLQueryItem(name: "language", value: self.language)]
        urlComp.queryItems = queryItem
        //let dict = ["language": self.language, "query": query]
//        urlComp.setQueryItems(with: dict)
        
        //var request = URLComponents(url: URL(string: "search/movie")!, resolvingAgainstBaseURL: true)
        var request = URLRequest(url: URL(string: "search/movie")!) // try urlComp.asURL())
        request.url = urlComp.url
//        let encoder = JSONEncoder()
        //request.httpBody = try JSONSerialization.data(withJSONObject: dict)
        //request.httpBody = try JSONEncoder().encode(self)
        //request.httpBody = dict.percentEncode()
        
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

extension Dictionary {
    
    /// Вспомогательный метод кодирования тела HTTP запроса на основе допустимых символов
    /// https://en.wikipedia.org/wiki/Percent-encoding
    func percentEncode() -> Data? {
        self.map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}
