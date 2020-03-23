//
//  SearchMovieMock.swift
//  TheMovieDatabaseTests
//
//  Created by Natali on 22.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation
@testable import TheMovieDatabase
@testable import TheMovieDatabaseAPI

class SearchMovieMock: SearchMoviesService {
    
    private var movies: [Movie]
    
    init(movies: [Movie] = .stub) {
        self.movies = movies
    }
    
    func fetchSearchMovies(language: String?,
                           query: String,
                           completion: @escaping (Result<[Movie], Error>) -> Void) {
        completion(Result.success(movies))
    }
    
}

class FavoriteMock: FavoriteServices {
    
    private var movies: [Movie]
    
    init(movies: [Movie] = .stubFavorite) {
        self.movies = movies
    }
    
    func fetchFavoriteMovies(accountId: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        completion(Result.success(movies))
    }
    
}
