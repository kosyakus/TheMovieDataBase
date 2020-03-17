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
    
    @IBOutlet weak var noMovieView: UIImageView!
    
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
    
    //Этим методом можно протестировать загрузку любимых фильмов и постеров
    
    func loadFavoriteMovies() {
        guard let session = try? ManageKeychain().getSessionID() else { return }
        TheMovieDatabaseAPI.FavoriteServices.parseMoviesFromJson(session: session) { result, error in
            if error != nil {
                print("Error \(String(describing: error))")
            } else {
                print("Favorite Movies \(String(describing: result))")
                guard let movies = result else { return }
                for movie in movies.results {
                    let url = URL(string: movie.getPoster())
                    self.noMovieView.load(url: url!)
                }
            }
        }
    }
    
    @objc func didTapEditButton(sender: AnyObject) {
        print("didTapEditButton")
    }

    @objc func didTapSearchButton(sender: AnyObject) {
    }

}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
