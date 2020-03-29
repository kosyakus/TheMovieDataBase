//
//  DeleteSessionService.swift
//  TheMovieDatabase
//
//  Created by Natali on 29.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation
import TheMovieDatabaseAPI

protocol DeleteSessionService {
    
    /// - Parameters:
    ///   - completionHandler: Обработчик результата входа.
    /// - Returns: Прогресс выполнения входа.
    @discardableResult
    func deleteSession(session: String,
                       completion: @escaping (Result<Bool, Error>) -> Void) -> Progress
}

final public class DeleteSessionServiceImplementation: DeleteSessionService {
    
    private let client: TheMovieDBAPIClient
    
    public init(client: TheMovieDBAPIClient) {
        self.client = client
    }
    
    @discardableResult
    func deleteSession(session: String,
                       completion: @escaping (Result<Bool, Error>) -> Void) -> Progress {
        
        client.request(DeleteSessionEndpoint(session: session)) { _ in
            completion(.success(true))
        }
    }
}
