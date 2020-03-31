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
            return #imageLiteral(resourceName: "list_icon")
        case .tableCell:
            return #imageLiteral(resourceName: "widgets_icon")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
        addContainerView()
    }
    
    // MARK: - Public methods
    
    func setUpNavBar() {
        let searchImage = #imageLiteral(resourceName: "search_icon")
        //let listImage = #imageLiteral(resourceName: "list_icon")
        
        let searchButton = UIBarButtonItem(image: buttonImage,
                                           style: .plain,
                                           target: self,
                                           action: #selector(didTapEditButton))
        let listButton = UIBarButtonItem(image: searchImage,
                                         style: .plain,
                                         target: self,
                                         action: #selector(didTapSearchButton))
        
        navigationItem.rightBarButtonItems = [listButton, searchButton]
    }
    
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
    
    private func addContainerView() {
        self.addChild(cellVC)
        cellVC.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        cellVC.view.frame = containerView.bounds
        containerView.addSubview(cellVC.collectionView)
        cellVC.didMove(toParent: self)
        self.delegate = cellVC
        delegate?.loadFavoriteMovies()
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
