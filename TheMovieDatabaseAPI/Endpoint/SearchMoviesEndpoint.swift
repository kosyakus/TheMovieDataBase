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
    
    public typealias Content = [APIMovie]

    private let language: String
    private let query: String
    public var params: [String : Any]?
    
    public init(language: String?, query: String) {
        self.query = query
        guard let lang = language else {
            self.language = Locale.current.languageCode!
            return
        }
        self.language = lang
    }
    
    public func makeRequest() throws -> URLRequest {
        
        var urlComp = URLComponents(string: "search/movie")!
        let dict = ["language": self.language, "query": query]
        urlComp.setQueryItems(with: dict)
        
        var request = URLRequest(url: URL(string: "search/movie")!)
        request.url = urlComp.url
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
