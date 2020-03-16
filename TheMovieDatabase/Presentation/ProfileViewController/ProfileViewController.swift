//
//  ProfileViewController.swift
//  TheMovieDatabase
//
//  Created by Natali on 07.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import UIKit

import TheMovieDatabaseAPI

class ProfileViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpButtonAndImage()
        loadProfile()
    }

    // MARK: - Public methods
    
    func setUpButtonAndImage() {
        exitButton.layer.cornerRadius = 0.02 * exitButton.bounds.size.width
        avatarImageView.layer.cornerRadius = 0.17 * exitButton.bounds.size.width
    }
    
    func loadProfile() {
        guard let session = try? ManageKeychain().getSessionID() else { return }
        TheMovieDatabaseAPI.AccountService.parseUserFromJson(session: session) { result in
            print("User \(result)")
            let decodedimage = result.hash.toUIImage
            self.avatarImageView.image = decodedimage
            if result.name != "" {
                self.nameLabel.text = result.name
            } else {
                self.nameLabel.text = result.username
            }
        }
    }
    
    // MARK: - IBAction
    
    @IBAction func exitButtonTapped(_ sender: Any) {
        guard let session = try? ManageKeychain().getSessionID() else { return }
        TheMovieDatabaseAPI.LoginService.deleteSession(session: session) { result in
            print("deletion result \(result)")
            try? ManageKeychain().deleteSessionId()
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            appDelegate?.presentViewController()
        }
    }
}
