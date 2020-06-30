//
//  ProfileViewController.swift
//  TheMovieDatabase
//
//  Created by Natali on 07.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    // MARK: - Private Properties
    
    private let accountService: AccountService
    private let deleteSessionService: DeleteSessionService
    private let deletionController = DeletionController()
    
    // MARK: - Initializers
    
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
        loadProfile()
        setUpButtonAndImage()
    }
    
    // MARK: - Public methods
    
    func setUpButtonAndImage() {
        exitButton.layer.cornerRadius = 0.02 * exitButton.bounds.size.width
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.size.height / 2
    }
    
    func loadProfile() {
        let loadAccController = LoadAccount()
        loadAccController.getUerDetails(completion: { user in
//            if let url = URL(string: "https://www.gravatar.com/avatar/b3a75a10fac1f519b4018d01466861f7") {
//                URLSession.shared.dataTask(with: url) { data, response, error in
//                    guard let data = data, let image = UIImage(data: data) else {
//                        return
//                    }
//                    self.avatarImageView.image = image
//                }
//            }
            
            if let avatar = user.avatar {
                self.avatarImageView.image = UIImage(data: avatar)
            }
            if let name = user.username {
                self.nameLabel.text = name
            }
        })
    }
    
    // MARK: - IBAction
    
    @IBAction func exitButtonTapped(_ sender: Any) {
        guard let session = try? ManageKeychain().getSessionID() else { return }
        deleteSessionService.deleteSession(session: session) { result in
            switch result {
            case .success:
                self.deletionController.deleteAllData()
                let appDelegate = UIApplication.shared.delegate as? AppDelegate
                appDelegate?.presentViewController(fromPinVC: false)
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
    @IBAction func dataBaseSegmentControlTapped(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            UserSettings.shareInstance.dataBase = 0
        case 1:
            UserSettings.shareInstance.dataBase = 1
        default:
            UserSettings.shareInstance.dataBase = 0
        }
    }
    
}
