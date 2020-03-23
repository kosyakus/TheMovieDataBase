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
    
    var searchMoviesService: SearchMoviesService
    
    init(searchMoviesService: SearchMoviesService = ServiceLayer.shared.searchMoviesService) {
        self.searchMoviesService = searchMoviesService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let searchIcon = "search_icon"
        if let image = UIImage(named: searchIcon) {
            findMovieTextField.setLeftView(image: image)
        }
        self.hideKeyboardWhenTappedAround()
        self.searchMovies(language: "ru-RU", query: "дулиттл")
    }
    
    func searchMovies(language: String?, query: String) {
        searchMoviesService.fetchSearchMovies(language: language, query: "дулиттл") { result in
            switch result {
            case .success(let movie):
                print(movie)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
//        TheMovieDatabaseAPI.SearchMoviesService.parseMoviesFromJson(language: language, query: query) { _ in
//            //print("Movies list \(result)")
//        }
    }
}
