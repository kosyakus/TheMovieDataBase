//
//  LoginService.swift
//  TheMovieDatabase
//
//  Created by Natali on 21.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Alamofire
import Foundation
import TheMovieDatabaseAPI

public class LoginService {
    
    // MARK: - Private Properties
    
    private static let apiKey = "93a57d2565c91c4db19ce6040806f41b"
    
    static func createToken(completion: @escaping (AFResult<Token>) -> Void) {
        TheMovieDatabaseAPI.APIClient.performRequest(
            route: TheMovieDatabaseAPI.LoginEndpoint.getCreateRequestToken(apiKey: apiKey),
            completion: completion)
    }
    
    static public func validateToken(username: String,
                                     password: String,
                                     requestToken: String,
                                     completion: @escaping (AFResult<Token>) -> Void) {
        TheMovieDatabaseAPI.APIClient.performRequest(route: TheMovieDatabaseAPI.LoginEndpoint.postValidateToken(username: username,
                                                                        password: password,
                                                                        requestToken: requestToken,
                                                                        apiKey: apiKey),
                                 completion: completion)
    }
    
    static func createSession(requestToken: String, completion: @escaping (AFResult<Session>) -> Void) {
        TheMovieDatabaseAPI.APIClient.performRequest(route: TheMovieDatabaseAPI.LoginEndpoint.postCreateSession(requestToken: requestToken,
                                                                        apiKey: apiKey),
                                 completion: completion)
    }
    
    static public func deleteSession(session: String, completion: @escaping (AFResult<DeletionResult>) -> Void) {
        TheMovieDatabaseAPI.APIClient.performRequest(route: TheMovieDatabaseAPI.LoginEndpoint.deleteSession(sessionId: session,
                                                                    apiKey: apiKey),
                                 completion: completion)
    }
    
    static public func parseTokenFromJson(completion: @escaping (Token) -> Void) {
        LoginService.createToken { result in
            switch result {
            case .success(let token):
                completion(token)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static public func parseSessionFromJson(requestToken: String, completion: @escaping (Session) -> Void) {
        LoginService.createSession(requestToken: requestToken) { result in
            switch result {
            case .success(let session):
                completion(session)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
