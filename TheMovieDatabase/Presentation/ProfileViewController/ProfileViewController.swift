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
    
    private let accountService: AccountService
    
    init(accountService: AccountService = ServiceLayer.shared.accountService) {
        self.accountService = accountService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        accountService.fetchUser() { result in
            print(result)
//            let decodedimage = result.avatar.gravatar.hash.toUIImage
//            self.avatarImageView.image = decodedimage
//            if !result.name.isEmpty {
//                self.nameLabel.text = result.name
//            } else {
//                self.nameLabel.text = result.username
//            }
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
