//
//  SearchMoviesEndpoint.swift
//  TheMovieDatabaseAPI
//
//  Created by Natali on 16.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation

public struct SearchMoviesEndpoint: Endpoint, Codable {
    
    public typealias Content = Movies

    private let language: String
    private let query: String
    private var params: [String: String]
    
    public init(language: String?, query: String) {
        self.query = query
        guard let lang = language else {
            self.language = Locale.current.languageCode!
            self.params = ["language": self.language, "query": query]
            return
        }
        self.language = lang
        self.params = ["language": self.language, "query": query]
    }
    
    public func makeRequest() throws -> URLRequest {
        var urlComp = URLComponents(string: "search/movie")!
        urlComp.setQueryItems(with: params)
        
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
