//
//  LoginService.swift
//  TheMovieDatabaseAPI
//
//  Created by Natali on 15.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Alamofire
import Foundation

public class LoginService {
    
    // MARK: - Types
    
    public typealias DownloadCompletion = () -> Void
    
    // MARK: - Private Properties
    
    private static let apiKey = "93a57d2565c91c4db19ce6040806f41b"
    private static var requestedToken = ""
    
    static func createToken(completion: @escaping (AFResult<Token>) -> Void) {
        APIClient.performRequest(route: LoginEndpoint.getCreateRequestToken(apiKey: apiKey),
                                 completion: completion)//.responseJSON { responseJSON in
    }
    
    static public func validateToken(username: String,
                                     password: String,
                                     requestToken: String,
                                     completion: @escaping (AFResult<Token>) -> Void) {
        APIClient.performRequest(route: LoginEndpoint.postValidateToken(username: "kosyak",
                                                                        password: "kosyakus",
                                                                        requestToken: requestToken,
                                                                        apiKey: LoginService.apiKey),
                                 completion: completion)
    }
    
    static public func createSession(requestToken: String, completion: @escaping (AFResult<Session>) -> Void) {
        APIClient.performRequest(route: LoginEndpoint.postCreateSession(requestToken: requestToken,
                                                                        apiKey: LoginService.apiKey),
                                 completion: completion)
    }
    
    static public func parseTokenFromJson(completion: @escaping (Token) -> Void) {
        UserService.createToken { result in
            switch result {
            case .success(let token):
                completion(token)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
