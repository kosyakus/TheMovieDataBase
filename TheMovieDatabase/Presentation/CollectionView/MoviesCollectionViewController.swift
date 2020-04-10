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

final class MoviesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Constants
    
    let collection = "collectionCell"
    let table = "tableCell"
    
    // MARK: - Public Properties
    
    var cellType: CellType = .collectionCell
    var moviesArray = [Movie]()
    
    var dataSource: CollectionViewDataSource<Movie>?
    
    // MARK: - MoviesCollectionViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .clear
        setUpCell()
        //self.moviesDidLoad(self.moviesArray)
        collectionView.contentInset = .init(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    // MARK: - Public methods
    
    /// Метод для регистрации ячейки коллекции
    func setUpCell() {
        self.collectionView!.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil),
                                      forCellWithReuseIdentifier: collection)
        self.collectionView!.register(UINib(nibName: "MovieTableCollectionViewCell", bundle: nil),
                                      forCellWithReuseIdentifier: table)
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
        self.collectionView.reloadData()
    }
    
    func reloadData() {
        self.collectionView.reloadData()
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
        switch cellType {
        case .collectionCell:
            cellIdentifier = collection
        case .tableCell:
            cellIdentifier = table
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier,
                                                      for: indexPath) as! MovieCollectionViewCell
        
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
    
    /// Переход из выбранной ячейки к детальному описанию фильма
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let filmDetailVC = FilmDetailViewController()
        filmDetailVC.movie = moviesArray[indexPath.row]
        self.navigationController?.pushViewController(filmDetailVC, animated: true)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    /// Анимированная перезагрузка ячеек таблицы
    override func collectionView(_ collectionView: UICollectionView,
                                 willDisplay cell: UICollectionViewCell,
                                 forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0.05 * Double(indexPath.row),
            animations: {
                cell.alpha = 1
            }
        )
    }
    
}
