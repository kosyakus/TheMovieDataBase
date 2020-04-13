//
//  RealmMovieViewModel.swift
//  TheMovieDatabase
//
//  Created by Natali on 12.04.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation
import TheMovieDatabaseDBLayer

class RealmMovieViewModel {

    private let repository: AnyRepository<RMovie>

    init(with repo: AnyRepository<RMovie>) {
        repository = repo
    }

    func saveRepository(movArray: [Movie]) {
        
        try? repository.deleteAll()
        
        for movie in movArray {
            let moviee = RMovie(id: movie.id, title: movie.title, originalTitle: movie.originalTitle,
                                voteAverage: movie.voteAverage, voteCount: movie.voteCount,
                                overview: movie.overview, poster: movie.poster)
            //insert
            try? repository.update(item: moviee)
            
            //get all
            let items: [RMovie] = repository.getAll()

            print("REALM Number of saved items: \(items.count)")
        }
    }
    
    func getMovies() -> [Movie] {
        var movies = [Movie]()
        let items: [RMovie] = repository.getAll()
        for item in items {
            let movie = Movie(id: item.id, title: item.title, originalTitle: item.originalTitle,
                              voteAverage: item.voteAverage, voteCount: item.voteCount,
                              overview: item.overview, poster: item.poster)
            movies.append(movie)
        }
        return movies
    }
    
    func deleteRepository() {
        try? repository.deleteAll()
    }
}
