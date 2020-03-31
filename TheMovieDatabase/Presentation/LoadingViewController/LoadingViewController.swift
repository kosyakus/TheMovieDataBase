//
//  LoadingViewController.swift
//  TheMovieDatabase
//
//  Created by Natali on 30.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    private lazy var activityIndicator = UIActivityIndicatorView(style: .gray)

    override func viewDidLoad() {
        super.viewDidLoad()

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = UIColor.CustomColor.light
        view.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Can be used a 0.5 second delay to not show an activity indicator
        // in case data loads very quickly.
        DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in
            self?.activityIndicator.startAnimating()
        }
    }
}
