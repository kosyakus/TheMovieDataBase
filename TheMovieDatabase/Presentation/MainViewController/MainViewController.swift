//
//  MainViewController.swift
//  TheMovieDatabase
//
//  Created by Natali on 07.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import TheMovieDatabaseAPI
import UIKit

class MainViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var findMovieTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let searchIcon = "search_icon"
        if let image = UIImage(named: searchIcon) {
            findMovieTextField.setLeftView(image: image)
        }
        self.hideKeyboardWhenTappedAround()
        self.searchMovies(language: "ru-RU", query: "дулиттл")
    }
    
    func searchMovies(language: String, query: String) {
        TheMovieDatabaseAPI.SearchMoviesService.parseMoviesFromJson(language: language, query: query) { _ in
            //print("Movies list \(result)")
        }
    }
}
