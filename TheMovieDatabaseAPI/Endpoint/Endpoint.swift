//
//  Endpoint.swift
//  TheMovieDatabaseAPI
//
//  Created by Natali on 14.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation

public protocol Endpoint {
    
    associatedtype Content
    
    func makeRequest() throws -> URLRequest
    
    /// data - данные, которые пришли по сети
    /// response - ответ, который пришел от сервера
    
    func content(from data: Data, response: URLResponse?) throws -> Content
}

//public struct PosterEndpoint: Endpoint {
//
//    public typealias Content = Data
//
//    public func makeRequest() throws -> URLRequest {
//        var request = URLRequest(url: URL(string: poster)!)
//        request.httpMethod = "GET"
//        return request
//    }
//
//    private var poster: String
//
//    public init(poster: String) {
//        self.poster = poster
//    }
//
//    public func content(from data: Data, response: URLResponse?) throws -> Content {
////        guard let response = response as? HTTPURLResponse else {
////            throw Error //APIError.invalidData
////        }
//        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
////
////        if response.statusCode != 200 {
////            let content = try decoder.decode(ErrorResponse.self, from: data)
////            switch content.statusCode {
////            case 7:
////                throw Error
////            default:
////                throw Error
////            }
////        }
//
//        let content = try decoder.decode(Content.self, from: data)
//        return content
//    }
//
//}
