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
    @IBOutlet weak var girlImageView: UIImageView!
    @IBOutlet weak var listButton: UIButton!
    
    // MARK: - Public Properties
    
    weak var delegate: ParentToChildProtocol?
    var containerView: UIView?
    let cellVC = MoviesCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
    var cellType: CellType = .collectionCell
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let searchIcon = "search_icon"
        if let image = UIImage(named: searchIcon) {
            findMovieTextField.setLeftView(image: image)
        }
        findMovieTextField.addTarget(self, action: #selector(textFieldDidTap(_:)), for: .touchDown)
        findMovieTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.hideKeyboardWhenTappedAround()
        self.checkUserIdExists()
    }
    
    func checkUserIdExists() {
        guard UserSettings.shareInstance.accountID.isEmpty else { return }
        LoadAccount().loadProfile()
    }
    
    @objc func textFieldDidTap(_ textField: UITextField) {
        findMovieLabel.isHidden = true
        findMovieStackView.frame.origin.y = 33
        girlImageView.isHidden = true
        addContainerView()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        delegate?.searchMovies(language: Locale.current.languageCode!, query: text)
    }
    
    // MARK: - Private Methods
    
    private func addContainerView() {
        self.containerView = UIView(frame: CGRect(x: 0, y: view.frame.origin.y + 100,
                                                  width: view.frame.width, height: view.frame.height - 100))
        self.view.addSubview(containerView!)
        self.addChild(cellVC)
        cellVC.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        cellVC.view.frame = containerView?.bounds ?? view.bounds
        containerView?.addSubview(cellVC.collectionView)
        cellVC.didMove(toParent: self)
        self.delegate = cellVC
    }
    
    private func removeContainerView() {
        cellVC.willMove(toParent: nil)
        cellVC.collectionView.removeFromSuperview()
        cellVC.removeFromParent()
    }
    
    @IBAction func listButtonTapped(_ sender: Any) {
        print("didTapListButton")
        delegate?.navBarButtonClickedByUser()
        switch cellType {
        case .collectionCell:
            cellType = .tableCell
        case .tableCell:
            cellType = .collectionCell
        }
    }
}
