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
    private let deleteSessionService: DeleteSessionService
    
    init(accountService: AccountService = ServiceLayer.shared.accountService,
         deleteSessionService: DeleteSessionService = ServiceLayer.shared.deleteSessionService) {
        self.accountService = accountService
        self.deleteSessionService = deleteSessionService
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
            switch result {
            case .success(let user):
                let decodedimage = user.avatar.gravatar.hash.toUIImage
                self.avatarImageView.image = decodedimage
                if !user.name.isEmpty {
                    self.nameLabel.text = user.name
                } else {
                    self.nameLabel.text = user.username
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - IBAction
    
    @IBAction func exitButtonTapped(_ sender: Any) {
        guard let session = try? ManageKeychain().getSessionID() else { return }
        deleteSessionService.deleteSession(session: session) { result in
            switch result {
            case .success:
                try? ManageKeychain().deleteSessionId()
                let appDelegate = UIApplication.shared.delegate as? AppDelegate
                appDelegate?.presentViewController()
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
}
