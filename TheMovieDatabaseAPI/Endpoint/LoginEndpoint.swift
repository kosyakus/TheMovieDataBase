//
//  LoginEndpoint.swift
//  TheMovieDatabaseAPI
//
//  Created by Natali on 15.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation

public struct TokenEndpoint: Endpoint, Codable {
    
    public typealias Content = APIToken
    
    public init() {}
    
    public func makeRequest() throws -> URLRequest {
        
        var request = URLRequest(url: URL(string: "authentication/token/new")!)
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

public struct ValidateTokenEndpoint: Endpoint, Codable {
    
    public typealias Content = ResponseResult

    private let login: String
    private let password: String
    private let token: String
    private var params: [String: String]
    
    public init(login: String, password: String, token: String) {
        self.login = login
        self.password = password
        self.token = token
        self.params = ["username": login, "password": password, "request_token": token]
    }
    
    public func makeRequest() throws -> URLRequest {
        var request = URLRequest(url: URL(string: "authentication/token/validate_with_login")!)
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

public struct CreateSessionEndpoint: Endpoint, Codable {
    
    public typealias Content = APISession

    private let token: String
    private var params: [String: String]
    
    public init(token: String) {
        self.token = token
        self.params = ["request_token": token]
    }
    
    public func makeRequest() throws -> URLRequest {
        var request = URLRequest(url: URL(string: "authentication/session/new")!)
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
