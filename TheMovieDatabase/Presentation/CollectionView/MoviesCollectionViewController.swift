//
//  MoviesCollectionViewController.swift
//  TheMovieDatabase
//
//  Created by Natali on 30.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import UIKit

enum CellType {
    case collectionCell, tableCell
}

class MoviesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Public Properties
    
    var cellType: CellType = .collectionCell
    var moviesArray = [Movie]()
    let favoriteService: FavoriteServices = ServiceLayer.shared.favoriteService
    let searchMoviesService: SearchMoviesService = ServiceLayer.shared.searchMoviesService
    
    // MARK: - MoviesCollectionViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .clear
        setUpCell()
    }
    
    // MARK: - Public methods
    
    /// Метод для регистрации ячейки коллекции
    func setUpCell() {
        switch cellType {
        case .collectionCell:
            self.collectionView!.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil),
                                          forCellWithReuseIdentifier: "collectionCell")
        case .tableCell:
            self.collectionView!.register(UINib(nibName: "MovieTableCollectionViewCell", bundle: nil),
                                          forCellWithReuseIdentifier: "tableCell")
        }
    }
}

extension MoviesCollectionViewController: ParentToChildProtocol {
    
    /// Метод для переключения типов ячейки коллекции
    func navBarButtonClickedByUser() {
        switch cellType {
        case .collectionCell:
            cellType = .tableCell
        case .tableCell:
            cellType = .collectionCell
        }
        setUpCell()
        self.collectionView.reloadData()
    }
    
    /// Метод для загрузки любимых фильмов.  Получает фильмы, добавляет их в moviesArray и обновляет коллекцию
    func loadFavoriteMovies() {
        favoriteService.fetchFavoriteMovies(accountId: UserSettings.shareInstance.accountID) { result in
            //print(result)
            var array = [Movie]()
            switch result {
            case .success(let movies):
                for movie in movies {
                    array.append(movie)
                }
                self.moviesArray = array
                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
            
            }
        }
    }
    
    /// Метод для поиска любимых фильмов.  Получает фильмы, добавляет их в moviesArray и обновляет коллекцию
    func searchMovies(language: String?, query: String) {
        searchMoviesService.fetchSearchMovies(language: language, query: query) { result in
            var array = [Movie]()
            switch result {
            case .success(let movies):
                for movie in movies {
                    array.append(movie)
                }
                self.moviesArray = array
                self.collectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

    // MARK: - UICollectionViewDataSource

extension MoviesCollectionViewController {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard !moviesArray.isEmpty else {

            return 0 }
        return moviesArray.count
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cellIdentifier = ""
        if cellType == .tableCell {
            cellIdentifier = "tableCell"
        } else {
            cellIdentifier = "collectionCell"
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier,
                                                      for: indexPath) as! MovieCollectionViewCell

        guard !moviesArray.isEmpty else { return cell }
        let movie = moviesArray[indexPath.row]
        if let poster = movie.poster {
            cell.movieImageView.load(url: poster)
        }
        cell.movieNameLabel.text = movie.title
        cell.originalMovieNameLabel.text = movie.originalTitle
        cell.voteLabel.text = "\(movie.voteAverage ?? 0)"
        cell.voteCountLabel.text = "\(movie.voteCount ?? 0)"

        return cell
    }
}

    // MARK: - UICollectionViewDelegate

extension MoviesCollectionViewController {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if cellType == .tableCell {
            return CGSize(width: 328, height: 98)
        } else {
            return CGSize(width: 152, height: 302)
        }
    }

}
