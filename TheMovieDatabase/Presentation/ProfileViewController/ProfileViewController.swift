//
//  ProfileViewController.swift
//  TheMovieDatabase
//
//  Created by Natali on 07.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import UIKit
import TheMovieDatabaseDBLayer

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
        
        setUpButtonAndImage()
        //addNoMovieElements()
        //createParticles()
    }
    
    // MARK: - Public methods
    
    func setUpButtonAndImage() {
        exitButton.layer.cornerRadius = 0.02 * exitButton.bounds.size.width
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.size.height / 2
    }
    
    /// Удаленеие всех записей из БД
    func deleteAllFromDB() {
        let viewModel = RealmMovieViewModel(with: AnyRepository())
        viewModel.deleteRepository()
        let CDviewModel = CDMovieViewModel(with: CoreDataRepository(persistentContainer:
            CoreDataService.shared.persistentContainer))
        CDviewModel.deleteRepository()
        
        UserSettings.shareInstance.dataBase = 0
    }
    
    // MARK: - IBAction
    
    @IBAction func exitButtonTapped(_ sender: Any) {
        guard let session = try? ManageKeychain().getSessionID() else { return }
        deleteSessionService.deleteSession(session: session) { result in
            switch result {
            case .success:
                try? ManageKeychain().deleteSessionId()
                UserSettings.shareInstance.accountID = ""
                self.deleteAllFromDB()
                let appDelegate = UIApplication.shared.delegate as? AppDelegate
                appDelegate?.presentViewController()
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
