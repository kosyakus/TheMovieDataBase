//
//  MoviesDataSource.swift
//  TheMovieDatabase
//
//  Created by Natali on 31.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation
import UIKit

   // MARK: - UICollectionViewDataSource

extension MoviesCollectionViewController {
    func moviesDidLoad(_ movies: [Movie]) {
        var cellIdentifier = ""
        if cellType == .tableCell {
            cellIdentifier = "tableCell"
        } else {
            cellIdentifier = "collectionCell"
        }
        self.dataSource = .make(for: movies, reuseIdentifier: cellIdentifier)
        collectionView.dataSource = dataSource
    }
}

class CollectionViewDataSource<Model>: NSObject, UICollectionViewDataSource {
    typealias CellConfigurator = (Model, MovieCollectionViewCell) -> Void

    var models: [Model]

    private let reuseIdentifier: String
    private let cellConfigurator: CellConfigurator

    init(models: [Model],
         reuseIdentifier: String,
         cellConfigurator: @escaping CellConfigurator) {
        self.models = models
        self.reuseIdentifier = reuseIdentifier
        self.cellConfigurator = cellConfigurator
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard models.isEmpty else {
            
            return 0 }
        return models.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: reuseIdentifier,
            for: indexPath
        ) as! MovieCollectionViewCell
        
        guard models.isEmpty else { return cell }
        let model = models[indexPath.row]

        cellConfigurator(model, cell)

        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 328, height: 98)
    }
}

extension CollectionViewDataSource where Model == Movie {
    static func make(for movies: [Movie],
                     reuseIdentifier: String) -> CollectionViewDataSource {
        let tvds = CollectionViewDataSource(
            models: movies,
            reuseIdentifier: reuseIdentifier
        ) { movie, cell in
            if let poster = movie.poster {
                cell.movieImageView.load(url: poster)
            }
            cell.movieNameLabel.text = movie.title
            cell.originalMovieNameLabel.text = movie.originalTitle
            cell.voteLabel.text = "\(movie.voteAverage ?? 0)"
            cell.voteCountLabel.text = "\(movie.voteCount ?? 0)"
            
        }
        return tvds
    }
}
