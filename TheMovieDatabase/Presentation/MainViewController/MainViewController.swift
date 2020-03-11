//
//  MainViewController.swift
//  TheMovieDatabase
//
//  Created by Natali on 07.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var findMovieTextField: UITextField!
    // MARK: - Initializers
    init() {
        super.init(nibName: "MainViewController", bundle: Bundle(for: MainViewController.self))
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let image = UIImage.init(named: "search_icon") {
            findMovieTextField.setLeftView(image: image)
        }
        self.hideKeyboardWhenTappedAround()
    }
}
