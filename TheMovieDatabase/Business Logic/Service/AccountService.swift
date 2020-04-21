//
//  AccountService.swift
//  TheMovieDatabase
//
//  Created by Natali on 22.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation
import TheMovieDatabaseAPI

protocol AccountService {

    /// - Parameters:
    ///   - completionHandler: Обработчик результата входа.
    /// - Returns: Прогресс выполнения входа.
    @discardableResult
    func fetchUser(session: String,
                   completion: @escaping (User) -> Void) -> Progress
}

final public class AccountServicesImplementation: AccountService {
    
    private let client: TheMovieDBAPIClient
    
    public init(client: TheMovieDBAPIClient) {
        self.client = client
    }
    
    @discardableResult
    func fetchUser(session: String,
                   completion: @escaping (User) -> Void) -> Progress {
        
        client.request(AccountEndpoint(session: session)) { result in
            switch result {
            case .success(let user):
                completion(self.user(from: user))
            case .failure(let error):
                print(error.localizedDescription)
            }
            
            //completion(result)
        }
    }
    
    private func user(from user: APIUser) -> User {
        User(username: user.username,
             id: user.id,
             avatar: URL(string: "https://www.gravatar.com/avatar/\(user.avatar.gravatar.hash)")?.convertUrlToData())
    }
}
