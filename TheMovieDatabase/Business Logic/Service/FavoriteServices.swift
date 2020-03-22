//
//  FavoriteServices.swift
//  TheMovieDatabase
//
//  Created by Natali on 21.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation
import TheMovieDatabaseAPI

/// Сервис работы с избранным.
public protocol FavoriteServices {

    /// Загрузка избранных фильмов.
    ///
    /// - Parameters:
    ///   - completionHandler: Обработчик результата входа.
    /// - Returns: Прогресс выполнения входа.
    @discardableResult
    func obtainFavoriteMovies(
        accountId: String,
        completion: @escaping (Result<Movies, Error>) -> Void) -> Progress
}

final public class FavoriteServicesImplementation: FavoriteServices {
    
    private let client: TheMovieDBAPIClient
    
    public init(client: TheMovieDBAPIClient) {
        self.client = client
    }
    
    @discardableResult
    public func obtainFavoriteMovies(
        accountId: String,
        completion: @escaping (Result<Movies, Error>) -> Void) -> Progress {
        
        client.request(FavoriteEndpoint(accountId: accountId)) { result in
            completion(result)
        }
    }
}
