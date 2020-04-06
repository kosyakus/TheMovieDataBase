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
        avatarImageView.layer.cornerRadius = 0.17 * exitButton.bounds.size.width
    }
    
    // MARK: - IBAction
    
    @IBAction func exitButtonTapped(_ sender: Any) {
        guard let session = try? ManageKeychain().getSessionID() else { return }
        deleteSessionService.deleteSession(session: session) { result in
            switch result {
            case .success:
                try? ManageKeychain().deleteSessionId()
                UserSettings.shareInstance.accountID = ""
                let appDelegate = UIApplication.shared.delegate as? AppDelegate
                appDelegate?.presentViewController()
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
    var ufoImage = UIImageView()
    
    func addNoMovieElements() {
        ufoImage = UIImageView(frame: CGRect(x: 64, y: 244, width: 248, height: 162))
        ufoImage.image = UIImage(named: "wheel_part")
        self.view.addSubview(ufoImage)
    }
    
}
