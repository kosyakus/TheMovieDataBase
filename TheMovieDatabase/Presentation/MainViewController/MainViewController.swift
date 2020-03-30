//
//  MainViewController.swift
//  TheMovieDatabase
//
//  Created by Natali on 07.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var findMovieTextField: UITextField!
    
    // MARK: - Public Properties
    
    var searchMoviesService: SearchMoviesService
    
    // MARK: - Initializers
    
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
        findMovieTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.hideKeyboardWhenTappedAround()
        self.checkUserIdExists()
        
        //self.searchMovies(language: "ru-RU", query: "дулиттл")
    }
    
    func searchMovies(language: String?, query: String) {
        searchMoviesService.fetchSearchMovies(language: language, query: query) { result in
            switch result {
            case .success(let movie):
                print(movie)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func checkUserIdExists() {
        guard UserSettings.shareInstance.accountID.isEmpty else { return }
        LoadAccount().loadProfile()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        self.searchMovies(language: Locale.current.languageCode!, query: text)
    }
}
