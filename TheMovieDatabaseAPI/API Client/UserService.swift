//
//  UserService.swift
//  TheMovieDatabase
//
//  Created by Natali on 09.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation

import Alamofire
import TheMovieDatabase

public final class UserService {
    
    // MARK: - Types
    
    typealias DownloadCompletion = () -> Void
    
    // MARK: - Private Properties
    
    private var requestedToken = ""
    private let apiKey = "93a57d2565c91c4db19ce6040806f41b"
    static let serviceName = "MovieService"
    let user = User()
    
    func createToken(username: String, password: String, completion: @escaping DownloadCompletion) {
        AF.request(Router.getCreateRequestToken(apiKey: apiKey)).responseJSON { [weak self] response in
            if let statusCode = response.response?.statusCode {
                
            }
            
            switch response.result {
            case .success(let rawJson):
                self?.parseTokenFromJson(username: username, password: password, rawJson: rawJson) { completion() }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func validateToken(username: String,
                       password: String,
                       requestToken: String,
                       completion: @escaping DownloadCompletion) {
        AF.request(Router.postValidateToken(username: username, password: password,
                                            requestToken: requestedToken,
                                            apiKey: apiKey)).responseJSON { [weak self] response in
                                                switch response.result {
                                                case .success:
                                                    self?.user.login = username
                                                    self?.createSession { completion() }
                                                case .failure(let error):
                                                    print(error)
                                                }
        }
    }
    
    func createSession(completion: @escaping DownloadCompletion) {
        AF.request(Router.postCreateSession(requestToken: requestedToken,
                                            apiKey: apiKey)).responseJSON { [weak self] response in
                                                switch response.result {
                                                case .success(let rawJson):
                                                    //print("Session created successfully \(JSON(rawJson))")
                                                    self?.parseSessionId(rawJson: rawJson) { completion() }
                                                case .failure(let error):
                                                    print(error)
                                                }
        }
    }
    
    func deleteSession(completion: @escaping DownloadCompletion) {
        let sessionId = getSessionID()
        AF.request(Router.deleteSession(sessionId: sessionId, apiKey: apiKey)).responseJSON { [weak self] response in
            switch response.result {
            case .success(let rawJson):
                //print("Session deleted successfully \(JSON(rawJson))")
                try? self?.deleteSessionId()
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func parseTokenFromJson(username: String,
                                    password: String,
                                    rawJson: Any,
                                    completion: @escaping DownloadCompletion) {
        let json = JSON(rawJson)
        //print("JSON received successfully \(json)")
        guard let requestToken = json["request_token"].string else { return }
        requestedToken = requestToken
        self.validateToken(username: username, password: password, requestToken: requestToken) { completion() }
    }
    
    private func parseSessionId(rawJson: Any, completion: @escaping DownloadCompletion) {
        let json = JSON(rawJson)
        guard let sessionId = json["session_id"].string else { return }
        try? saveSessionId(sessionId: sessionId, user: user)
        completion()
    }
    
    private func readErrors(rawJson: Any) {
        let json = JSON(rawJson)
        guard let statusCode = json["status_code"].int else { return }
        if statusCode == 30 {
            print("Неверный логин или пароль")
        }
    }
    
    private func getSessionID() -> String {
        var sessionId = ""
        guard let currentUser = KeychainSettings.currentUser else { return sessionId }
        sessionId = try! KeychainPasswordItem(service: UserService.serviceName, account: currentUser.email).service
        return sessionId
    }
    
    private func saveSessionId(sessionId: String, user: User) throws {
        try KeychainPasswordItem(service: UserService.serviceName, account: user.login).savePassword(sessionId)
        KeychainSettings.currentUser = user
        NotificationCenter.default.post(name: .loginStatusChanged, object: nil)
    }
    
    private func deleteSessionId() throws {
      guard let currentUser = KeychainSettings.currentUser else { return }
      try KeychainPasswordItem(service: UserService.serviceName, account: currentUser.email).deleteItem()
      KeychainSettings.currentUser = nil
      NotificationCenter.default.post(name: .loginStatusChanged, object: nil)
    }
}