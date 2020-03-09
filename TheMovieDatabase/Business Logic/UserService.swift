//
//  UserService.swift
//  TheMovieDatabase
//
//  Created by Natali on 09.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

class UserService {
    
    typealias downloadCompletion = () -> Void
    
    var requestedToken = ""
    let apiKey = "93a57d2565c91c4db19ce6040806f41b"
    
    func createToken(username: String, password: String, completion: @escaping downloadCompletion) {
        AF.request(Router.getCreateRequestToken(api_key: apiKey)).responseJSON { [weak self] response in
            switch response.result {
            case .success(let rawJson):
                self?.parseTokenFromJson(username: username, password: password, rawJson: rawJson) { completion() }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func parseTokenFromJson(username: String, password: String, rawJson: Any, completion: @escaping downloadCompletion) {
        let json = JSON(rawJson)
        //print("JSON received successfully \(json)")
        guard let requestToken = json["request_token"].string else { return }
        requestedToken = requestToken
        self.validateToken(username: username, password: password, request_token: requestToken) { completion() }
    }
    
    func validateToken(username: String, password: String, request_token: String, completion: @escaping downloadCompletion) {
        AF.request(Router.postValidateToken(username: username, password: password, request_token: requestedToken, api_key: apiKey)).responseJSON { [weak self] response in
            switch response.result {
            case .success:
                //print("Token validated successfully \(JSON(rawJson))")
                self?.createSession {completion()}
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func createSession(completion: @escaping downloadCompletion) {
        AF.request(Router.postCreateSession(request_token: requestedToken, api_key: apiKey)).responseJSON { [weak self] response in
            switch response.result {
            case .success(let rawJson):
                print("Session created successfully \(JSON(rawJson))")
                self?.parseSessionId(rawJson: rawJson) { completion() }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func parseSessionId(rawJson: Any, completion: @escaping downloadCompletion) {
        let json = JSON(rawJson)
        guard let sessionId = json["session_id"].string else { return }
        let user = User()
        user.isSessionCreated = true
        user.sessionId = sessionId
        self.saveUser(user: user)
        completion()
    }
    
    private func saveUser(user: User) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(user)
            }
        }  catch {
            print(error)
        }
    }
    
    private func deleteUser() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(realm.objects(User.self))
            }
        }  catch {
            print(error)
        }
    }
}
