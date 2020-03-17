//
//  FavoriveViewController.swift
//  TheMovieDatabase
//
//  Created by Natali on 07.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import TheMovieDatabaseAPI
import UIKit

class FavoriveViewController: UIViewController {
    
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
        guard let session = try? ManageKeychain().getSessionID() else { return }
        TheMovieDatabaseAPI.FavoriteService.parseMoviesFromJson(session: session) { result in
            print("Favorite Movies \(result)")
        }
    }
    
    @objc func didTapEditButton(sender: AnyObject) {
        print("didTapEditButton")
    }

    @objc func didTapSearchButton(sender: AnyObject) {
    }

}
