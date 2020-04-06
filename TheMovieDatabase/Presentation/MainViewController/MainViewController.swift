//
//  MainViewController.swift
//  TheMovieDatabase
//
//  Created by Natali on 07.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Constants
    
    private let listImage = #imageLiteral(resourceName: "list_icon")
    private let searchImage = #imageLiteral(resourceName: "search_icon")
    private let collectionImage = #imageLiteral(resourceName: "widgets_icon")
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var findMovieLabel: UILabel!
    @IBOutlet weak var findMovieTextField: UITextField!
    @IBOutlet weak var findMovieStackView: UIStackView!
    @IBOutlet weak var girlImageView: UIImageView!
    @IBOutlet weak var listButton: UIButton!
    @IBOutlet weak var topStackViewConstraint: NSLayoutConstraint!
    
    // MARK: - Public Properties
    
    weak var childVC: ParentToChildProtocol?
    let searchMoviesService: SearchMoviesService = ServiceLayer.shared.searchMoviesService
    let cellVC = MoviesCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
    var cellType: CellType = .collectionCell
    var ufoImage = UIImageView()
    var notFoundMovieLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        findMovieTextField.setLeftView(image: searchImage)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
        findMovieTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.hideKeyboardWhenTappedAround()
        self.checkUserIdExists()
        
        addNoMovieElements()
    }
    
    // MARK: - Public methods
    
    func checkUserIdExists() {
        guard UserSettings.shareInstance.accountID.isEmpty else { return }
        LoadAccount().loadProfile()
    }
    
    /// Обработка экрана при появлении клавиатуры
    @objc func keyboardWillShow(notification: NSNotification) {
        topStackViewConstraint.constant = -70
        findMovieStackView.setNeedsLayout()
        
        findMovieLabel.isHidden = true
        girlImageView.isHidden = true
        addCollection(cellVC)
    }
    
    /// Обработка экрана при скрытии клавиатуры
    @objc func keyboardWillHide(notification: NSNotification) {
    }
    
    /// Передаем делегат в child contriler при введении текста в полепоиска
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        self.searchMovies(language: Locale.current.languageCode!, query: text)
    }
    
    // MARK: - IBAction
    
    @IBAction func listButtonTapped(_ sender: Any) {
        print("didTapListButton")
        childVC?.navBarButtonClickedByUser()
        switch cellType {
        case .collectionCell:
            cellType = .tableCell
            listButton.imageView?.image = collectionImage
        case .tableCell:
            cellType = .collectionCell
            listButton.imageView?.image = listImage
        }
    }
    
    // MARK: - Private Methods
    
    /// Добавление childView
    private func addCollection(_ viewController: UIViewController) {
        self.addContainerView(viewController)
        self.childVC = cellVC
        cellVC.view.isHidden = true
    }
    
    /// Метод для поиска любимых фильмов.  Получает фильмы, добавляет их в moviesArray и обновляет коллекцию
    private func searchMovies(language: String?, query: String) {
        searchMoviesService.fetchSearchMovies(language: language, query: query) { result in
            switch result {
            case .success(let movies):
                if !movies.isEmpty {
                    self.proceedFindedMovieScreen()
                    self.childVC?.moviesArray = movies
                    self.childVC?.reloadData()
                } else {
                    self.proceedNoMovieScreen()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func addNoMovieElements() {
        ufoImage = UIImageView(frame: CGRect(x: 64, y: 244, width: 248, height: 215))
        ufoImage.image = UIImage(named: "ufo")
        self.view.addSubview(ufoImage)
        
        notFoundMovieLabel = UILabel(frame: CGRect(x: 24, y: 161, width: 220, height: 50))
        notFoundMovieLabel.text = "По вашему запросу ничего не найдено :("
        notFoundMovieLabel.numberOfLines = 0
        notFoundMovieLabel.font = UIFont(name: "SFProDisplay", size: 16)
        notFoundMovieLabel.textColor = UIColor.CustomColor.light
        self.view.addSubview(notFoundMovieLabel)
        
        ufoImage.isHidden = true
        notFoundMovieLabel.isHidden = true
    }
    
    func proceedNoMovieScreen() {
        cellVC.view.isHidden = true
        ufoImage.isHidden = false
        notFoundMovieLabel.isHidden = false
    }
    
    func proceedFindedMovieScreen() {
        cellVC.view.isHidden = false
        ufoImage.isHidden = true
        notFoundMovieLabel.isHidden = true
    }
}
