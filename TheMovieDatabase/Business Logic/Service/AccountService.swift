//
//  AccountService.swift
//  TheMovieDatabase
//
//  Created by Natali on 22.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation
import TheMovieDatabaseAPI

public protocol AccountService {

    /// - Parameters:
    ///   - completionHandler: Обработчик результата входа.
    /// - Returns: Прогресс выполнения входа.
    @discardableResult
    func fetchUser(session: String,
                   completion: @escaping (Result<User, Error>) -> Void) -> Progress
}

final public class AccountServicesImplementation: AccountService {
    
    private let client: TheMovieDBAPIClient
    
    public init(client: TheMovieDBAPIClient) {
        self.client = client
    }
    
    @discardableResult
    public func fetchUser(session: String,
                          completion: @escaping (Result<User, Error>) -> Void) -> Progress {
        
        client.request(AccountEndpoint(session: session)) { result in
            completion(result)
        }
    }
}
