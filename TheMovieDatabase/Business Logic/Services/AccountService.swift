//
//  AccountService.swift
//  TheMovieDatabase
//
//  Created by Natali on 21.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Alamofire
import Foundation
import TheMovieDatabaseAPI

public class AccountService {
    
    // MARK: - Private Properties
    
    private static let apiKey = "93a57d2565c91c4db19ce6040806f41b"
    
    static public func getAccountDetails(session: String, completion: @escaping (AFResult<User>) -> Void) {
        APIClient.performRequest(route: AccountEndpoint.getAccountDetails(sessionId: session,
                                                                          apiKey: apiKey),
                                 completion: completion)
    }
    
    static public func parseUserFromJson(session: String, completion: @escaping (User) -> Void) {
        AccountService.getAccountDetails(session: session) { result in
            switch result {
            case .success(let user):
                completion(user)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
