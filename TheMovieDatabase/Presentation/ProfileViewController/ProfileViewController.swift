//
//  ProfileViewController.swift
//  TheMovieDatabase
//
//  Created by Natali on 07.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import UIKit
import RealmSwift

class ProfileViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var avatarImageView: UIImageView!
    var user = User()
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
        showUser()
    }
    // MARK: - Public methods
    func showUser() {
        do {
            let realm = try Realm()
            let users = realm.objects(User.self)
            self.user = users[0]
        } catch {
            print(error)
        }
    }
    func setUpButtonAndImage() {
        exitButton.layer.cornerRadius = 0.02 * exitButton.bounds.size.width
        avatarImageView.layer.cornerRadius = 0.17 * exitButton.bounds.size.width
    }
    // MARK: - IBAction
    @IBAction func exitButtonTapped(_ sender: Any) {
        let userService = UserService()
        userService.deleteUser()
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.presentViewController()
        /*let sessionId = user.sessionId
        userService.deleteSession(sessionId: sessionId) {
            let appDelegate = UIApplication.shared.delegate! as! AppDelegate
            appDelegate.presentViewController()
        }*/
    }
}
