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
    
    func navBarButtonClickedByUser()
    func loadFavoriteMovies()
    func searchMovies(language: String?, query: String)
}

final class FavoriveViewController: UIViewController, UINavigationControllerDelegate {
    
    // MARK: - Constants
    
    private let listImage = #imageLiteral(resourceName: "list_icon")
    private let searchImage = #imageLiteral(resourceName: "search_icon")
    private let collectionImage = #imageLiteral(resourceName: "widgets_icon")
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var noMovieView: UIImageView!
    @IBOutlet weak var findMoviesButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    // MARK: - Public Properties
    
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
        addCollection(cellVC)
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
    
    /// Обновление изображения списка/таблицы
    private func updatePresentationStyle() {
        navigationItem.rightBarButtonItems?[1].image = buttonImage
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
        delegate?.loadFavoriteMovies()
    }
}
