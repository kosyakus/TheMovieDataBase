//
//  FavoriveViewController.swift
//  TheMovieDatabase
//
//  Created by Natali on 07.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import TheMovieDatabaseAPI
import UIKit

final class FavoriveViewController: UIViewController {
    
    @IBOutlet weak var noMovieView: UIImageView!
    @IBOutlet weak var findMoviesButton: UIButton!
    
    // MARK: - Public Properties
    
    var favoriteService: FavoriteServices
    
    // MARK: - Initializers
    
    init(favoriteService: FavoriteServices = ServiceLayer.shared.favoriteService) {
        self.favoriteService = favoriteService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
        loadFavoriteMovies()
    }
    
    // MARK: - Public methods
    
    func setUpNavBar() {
        let searchImage = #imageLiteral(resourceName: "search_icon")
        let listImage = #imageLiteral(resourceName: "list_icon")
        
        let searchButton = UIBarButtonItem(image: searchImage,
                                           style: .plain,
                                           target: self,
                                           action: #selector(didTapEditButton))
        let listButton = UIBarButtonItem(image: listImage,
                                         style: .plain,
                                         target: self,
                                         action: #selector(didTapSearchButton))
        
        self.navigationController?.navigationItem.rightBarButtonItems = [searchButton, listButton]
    }
    
    func loadFavoriteMovies() {
        
        favoriteService.fetchFavoriteMovies(accountId: "9116288") { result in //9121461
            print(result)
            switch result {
            case .success(let movies):
                for movie in movies {
                    let url = URL(string: movie.poster ?? "")
                self.noMovieView.load(url: url!)
                }
            case .failure(let error):
                print(error)
            
            }
        }
    }
    
    @objc func didTapEditButton(sender: AnyObject) {
        print("didTapEditButton")
    }
    
    @objc func didTapSearchButton(sender: AnyObject) {
        print("didTapSearchButton")
    }
    
}
