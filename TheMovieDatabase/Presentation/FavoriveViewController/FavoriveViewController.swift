//
//  FavoriveViewController.swift
//  TheMovieDatabase
//
//  Created by Natali on 07.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import TheMovieDatabaseAPI
import UIKit

protocol ParentToChildProtocol: class {
    
    var moviesArray: [Movie] { get set }
    
    func navBarButtonClickedByUser()
    func reloadData()
}

final class FavoriveViewController: UIViewController {
    
    // MARK: - Constants
    
    private let listImage = #imageLiteral(resourceName: "list_icon")
    private let searchImage = #imageLiteral(resourceName: "search_icon")
    private let collectionImage = #imageLiteral(resourceName: "widgets_icon")
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var noMovieView: UIImageView!
    @IBOutlet weak var noMovieLabel: UILabel!
    @IBOutlet weak var findMoviesButton: UIButton!
    
    // MARK: - Public Properties
    
    let favoriteService: FavoriteServices = ServiceLayer.shared.favoriteService
    let cellVC = MoviesCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
    var cellType: CellType = .collectionCell
    weak var delegate: ParentToChildProtocol?
    var buttonImage: UIImage {
        switch cellType {
        case .collectionCell:
            return listImage
        case .tableCell:
            return collectionImage
        }
    }
    
    // MARK: - FavoriveViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
        //loadFavoriteMovies()
    }
    
    // MARK: - Public methods
    
    func setUpNavBar() {
        let listButton = UIBarButtonItem(image: buttonImage,
                                         style: .plain,
                                         target: self,
                                         action: #selector(didTapEditButton))
        let searchButton = UIBarButtonItem(image: searchImage,
                                           style: .plain,
                                           target: self,
                                           action: #selector(didTapSearchButton))
        
        navigationItem.rightBarButtonItems = [listButton, searchButton]
    }
    
    @objc func didTapEditButton(sender: AnyObject) {
        print("didTapEditButton")
        delegate?.navBarButtonClickedByUser()
        switch cellType {
        case .collectionCell:
            cellType = .tableCell
        case .tableCell:
            cellType = .collectionCell
        }
        updatePresentationStyle()
    }
    
    @objc func didTapSearchButton(sender: AnyObject) {
        print("didTapSearchButton")
    }
    
    // MARK: - Private Methods
    
    /// Добавление childView
    private func addCollection(_ viewController: UIViewController) {
        self.addContainerView(viewController)
        self.delegate = cellVC
    }
    
    /// Метод для загрузки любимых фильмов.  Получает фильмы, добавляет их в moviesArray и обновляет коллекцию
    private func loadFavoriteMovies() {
        favoriteService.fetchFavoriteMovies { result in
            //print(result)
            switch result {
            case .success(let movies):
                if !movies.isEmpty {
                    self.addCollection(self.cellVC)
                    self.noMovieView.isHidden = true
                    self.noMovieLabel.isHidden = true
                    self.findMoviesButton.isHidden = true
                    self.delegate?.moviesArray = movies
                    self.delegate?.reloadData()
                }
            case .failure(let error):
                print(error)
            
            }
        }
    }
    
    /// Обновление изображения списка/таблицы
    private func updatePresentationStyle() {
        navigationItem.rightBarButtonItems?[0].image = buttonImage
    }
}
