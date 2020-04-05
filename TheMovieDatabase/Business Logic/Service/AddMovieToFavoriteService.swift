//
//  AddMovieToFavoriteService.swift
//  TheMovieDatabase
//
//  Created by Natali on 05.04.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation
import TheMovieDatabaseAPI

public protocol AddMovieToFavoriteService {

    /// - Parameters:
    ///   - completionHandler: Обработчик результата входа.
    /// - Returns: Прогресс выполнения входа.
    @discardableResult
    func addMovieToFavorite(movieId: Int,
                            completion: @escaping (Result<Bool, Error>) -> Void) -> Progress
}

final public class AddMovieToFavoriteServiceImplementation: AddMovieToFavoriteService {
    
    private let client: TheMovieDBAPIClient
    
    public init(client: TheMovieDBAPIClient) {
        self.client = client
    }
    
    @discardableResult
    public func addMovieToFavorite(movieId: Int,
                                   completion: @escaping (Result<Bool, Error>) -> Void) -> Progress {
        
        client.request(AddMovieToFavoriteEndpoint(accountId: UserSettings.shareInstance.accountID,
                                                  movieId: movieId)) { _ in
            completion(.success(true))
        }
    }
}
