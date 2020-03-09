//
//  ProfileViewController.swift
//  TheMovieDatabase
//
//  Created by Natali on 07.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    // MARK: - Initializers
    
    init() {
        super.init(nibName: "ProfileViewController", bundle: Bundle(for: ProfileViewController.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpButtonAndImage()
    }


    // MARK: - Public methods
    
    func setUpButtonAndImage() {
        exitButton.layer.cornerRadius = 0.02 * exitButton.bounds.size.width
        avatarImageView.layer.cornerRadius = 0.17 * exitButton.bounds.size.width
    }
    
    // MARK: - IBAction
    
    @IBAction func exitButtonTapped(_ sender: Any) {
        let vc = LoginViewController()
        navigationController?.pushViewController(vc, animated: true)
        //self.present(vc, animated: true, completion: nil)
    }
    
}
