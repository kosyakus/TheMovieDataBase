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
    
    // MARK: - Public Properties
    
    weak var delegate: ParentToChildProtocol?
    let cellVC = MoviesCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
    var cellType: CellType = .collectionCell
    
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
    }
    
    // MARK: - Public methods
    
    func checkUserIdExists() {
        guard UserSettings.shareInstance.accountID.isEmpty else { return }
        LoadAccount().loadProfile()
    }
    
    /// Обработка экрана при появлении клавиатуры
    @objc func keyboardWillShow(notification: NSNotification) {
        findMovieStackView.frame.origin.y = 30
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
        delegate?.searchMovies(language: Locale.current.languageCode!, query: text)
    }
    
    // MARK: - IBAction
    
    @IBAction func listButtonTapped(_ sender: Any) {
        print("didTapListButton")
        delegate?.navBarButtonClickedByUser()
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
        self.delegate = cellVC
    }
}
