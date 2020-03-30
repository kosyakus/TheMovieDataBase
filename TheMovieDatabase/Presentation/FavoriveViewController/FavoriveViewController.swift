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
}

final class FavoriveViewController: UIViewController {
    
    @IBOutlet weak var noMovieView: UIImageView!
    @IBOutlet weak var findMoviesButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    // MARK: - Public Properties
    
    //var favoriteService: FavoriteServices
    let cellVC = MoviesCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
    var cellType: CellType = .collectionCell
    weak var delegate: ParentToChildProtocol?
    
    var buttonImage: UIImage {
        switch cellType {
        case .collectionCell:
            return #imageLiteral(resourceName: "list_icon")
        case .tableCell:
            return #imageLiteral(resourceName: "widgets_icon")
        }
    }
    
    // MARK: - Initializers
    
//    init(favoriteService: FavoriteServices = ServiceLayer.shared.favoriteService) {
//        self.favoriteService = favoriteService
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
        updatePresentationStyle()
        
        delegate?.loadFavoriteMovies()
        
        addContainerView()
    }
    
    // MARK: - Public methods
    
    func setUpNavBar() {
        let searchImage = #imageLiteral(resourceName: "search_icon")
        //let listImage = #imageLiteral(resourceName: "list_icon")
        
        let searchButton = UIBarButtonItem(image: searchImage,
                                           style: .plain,
                                           target: self,
                                           action: #selector(didTapEditButton))
        let listButton = UIBarButtonItem(image: buttonImage,
                                         style: .plain,
                                         target: self,
                                         action: #selector(didTapSearchButton))
        
        navigationItem.rightBarButtonItems = [searchButton, listButton]
    }
    
    private func updatePresentationStyle() {
        self.navigationController?.navigationItem.rightBarButtonItem?.image = buttonImage
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
    
    private func addContainerView() {
        self.addChild(cellVC)
        cellVC.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        cellVC.view.frame = containerView.bounds
        containerView.addSubview(cellVC.collectionView)
        cellVC.didMove(toParent: self)
    }
    
    private func removeContainerView() {
        // Notify Child View Controller
        cellVC.willMove(toParent: nil)
        // Remove Child View From Superview
        cellVC.collectionView.removeFromSuperview()
        // Notify Child View Controller
        cellVC.removeFromParent()
    }
    
//    private func updateView() {
//        if self.navigationController?.navigationItem.rightBarButtonItems?[0] {
//
//        }
//        if segmentedControl.selectedSegmentIndex == 0 {
//            remove(asChildViewController: sessionsViewController)
//            add(asChildViewController: summaryViewController)
//        } else {
//            remove(asChildViewController: summaryViewController)
//            add(asChildViewController: sessionsViewController)
//        }
//    }
    
}
