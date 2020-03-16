//
//  SearchMoviesEndpoint.swift
//  TheMovieDatabaseAPI
//
//  Created by Natali on 16.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Alamofire
import Foundation

enum SearchMoviesEndpoint: URLRequestConvertible {
    
    case getMoviesList(language: String, query: String, apiKey: String)
    
    private var basePath: String {
        "https://api.themoviedb.org/3/"
    }
    
    private var path: String {
        switch self {
        case .getMoviesList:
            return "search/movie"
        }
    }
    
    private var method: HTTPMethod {
        switch self {
        case .getMoviesList:
            return .get
        }
    }
    
    private var parameters: Parameters {
        switch self {
        case let .getMoviesList(language, query, apiKey):
            return ["language": language, "query": query, "api_key": apiKey]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try basePath.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        // Common Headers
        urlRequest.setValue(Constants.ProductionServer.apiKey,
                            forHTTPHeaderField: Constants.HTTPHeaderField.authentication.rawValue)
        return try URLEncoding.queryString.encode(urlRequest, with: parameters)
    }
}
