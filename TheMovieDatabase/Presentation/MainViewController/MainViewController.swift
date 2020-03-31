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
    
    @IBOutlet weak var findMovieLabel: UILabel!
    @IBOutlet weak var findMovieTextField: UITextField!
    @IBOutlet weak var findMovieStackView: UIStackView!
    
    // MARK: - Public Properties
    
    weak var delegate: ParentToChildProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let searchIcon = "search_icon"
        if let image = UIImage(named: searchIcon) {
            findMovieTextField.setLeftView(image: image)
        }
        findMovieTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .allTouchEvents)
        findMovieTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.hideKeyboardWhenTappedAround()
        self.checkUserIdExists()
    }
    
    func checkUserIdExists() {
        guard UserSettings.shareInstance.accountID.isEmpty else { return }
        LoadAccount().loadProfile()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        findMovieLabel.isHidden = true
        guard let text = textField.text else { return }
        delegate?.searchMovies(language: Locale.current.languageCode!, query: text)
    }
}
