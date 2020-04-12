//
//  CDMovieViewModel.swift
//  TheMovieDatabase
//
//  Created by Natali on 12.04.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation
import TheMovieDatabaseDBLayer

class CDMovieViewModel {
    
    private let repository: CoreDataRepository<RMovie>
    
    init(with repo: CoreDataRepository<RMovie>) {
        repository = repo
    }
    
    func saveRepository(movArray: [Movie]) {
        //try? repository.deleteAll()
        for movie in movArray {
            let movie = RMovie(id: movie.id, title: movie.title, originalTitle: movie.originalTitle,
                               voteAverage: movie.voteAverage, voteCount: movie.voteCount,
                               overview: movie.overview, poster: movie.poster)
            //insert article
            try? repository.update(item: movie)
            //get all articles
            // swiftlint:disable:next force_try
            let items: [RMovie] = try! repository.getAll(where: nil)
            
            print("CoreDATA Number of saved items: \(items.count)")
        }
    }
    
    func deleteRepository() {
        try? repository.deleteAll()
        // swiftlint:disable:next force_try
        let items: [RMovie] = try! repository.getAll(where: nil)
        
        print("CoreDATA Number of existing items after deletion: \(items.count)")
    }
}
