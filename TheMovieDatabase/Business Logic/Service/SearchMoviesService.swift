//
//  SearchMoviesService.swift
//  TheMovieDatabase
//
//  Created by Natali on 22.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation
import TheMovieDatabaseAPI

protocol SearchMoviesService {
    
    /// - Parameters:
    ///   - completionHandler: Обработчик результата входа.
    /// - Returns: Прогресс выполнения входа.
    @discardableResult
    func fetchSearchMovies(
        language: String?,
        query: String,
        completion: @escaping (Result<[Movie], Error>) -> Void) -> Progress
}

final public class SearchMoviesServiceImplementation: SearchMoviesService {
    
    private let client: TheMovieDBAPIClient
    
    public init(client: TheMovieDBAPIClient) {
        self.client = client
    }
    
    @discardableResult
    func fetchSearchMovies(language: String?,
                           query: String,
                           completion: @escaping (Result<[Movie], Error>) -> Void) -> Progress {
        
        client.request(SearchMoviesEndpoint(language: language, query: query)) { result in
            let moviesResult = result.flatMap { movies -> Result<[Movie], Error> in
                let movies = movies.results.map(self.movie(from:))
                return .success(movies)
            }
            completion(moviesResult)
        }
    }
    
    private func movie(from movie: APIMovie) -> Movie {
        Movie(
            id: movie.id,
            title: movie.title,
            originalTitle: movie.originalTitle,
            voteAverage: movie.voteAverage,
            voteCount: movie.voteCount,
            overview: movie.overview,
            poster: URL(string: "https://image.tmdb.org/t/p/w185\(movie.posterPath ?? "")")?.convertUrlToData())
    }
}
