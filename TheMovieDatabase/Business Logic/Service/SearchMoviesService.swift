//
//  SearchMoviesService.swift
//  TheMovieDatabase
//
//  Created by Natali on 22.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation
import TheMovieDatabaseAPI

public protocol SearchMoviesService {

    /// - Parameters:
    ///   - completionHandler: Обработчик результата входа.
    /// - Returns: Прогресс выполнения входа.
    @discardableResult
    func fetchSearchMovies(
        language: String?,
        query: String,
        completion: @escaping (Result<Movies, Error>) -> Void) -> Progress
}

final public class SearchMoviesServiceImplementation: SearchMoviesService {
    
    private let client: TheMovieDBAPIClient
    
    public init(client: TheMovieDBAPIClient) {
        self.client = client
    }
    
    @discardableResult
    public func fetchSearchMovies(
        language: String?,
        query: String,
        completion: @escaping (Result<Movies, Error>) -> Void) -> Progress {
        
        client.request(SearchMoviesEndpoint(language: language, query: query)) { result in
            completion(result)
        }
    }
}
