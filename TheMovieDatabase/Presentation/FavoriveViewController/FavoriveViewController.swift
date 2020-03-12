//
//  FavoriveViewController.swift
//  TheMovieDatabase
//
//  Created by Natali on 07.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import UIKit

class FavoriveViewController: UIViewController {
    
    // MARK: - Initializers
    
    init() {
        super.init(nibName: "FavoriveViewController", bundle: Bundle(for: FavoriveViewController.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let searchImage = UIImage(named: "search_icon")!
        let listImage = UIImage(named: "list_icon")!

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
    
    // MARK: - Public methods
    
    @objc func didTapEditButton(sender: AnyObject) {
        print("didTapEditButton")
    }

    @objc func didTapSearchButton(sender: AnyObject) {
    }

}
