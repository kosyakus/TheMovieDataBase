//
//  LoginViewController.swift
//  TheMovieDatabase
//
//  Created by Natali on 06.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    
    let userService = UserService()
    
    // MARK: - Initializers
    
    init() {
        super.init(nibName: "LoginViewController", bundle: Bundle(for: LoginViewController.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        passwordTextField.addTap()
        passwordTextField.setVisibilityOnIcon()
        setUpButton()
        
        userService.createToken {
            print("token created")
        }
        
    }


    // MARK: - Public methods
    
    func setUpButton() {
        enterButton.layer.cornerRadius = 0.02 * enterButton.bounds.size.width
    }
    

    // MARK: - IBAction
    
    @IBAction func tapEnterButton(_ sender: Any) {
        
        enterButton.titleLabel?.textColor = UIColor(named: "Light")
        enterButton.backgroundColor = UIColor(named: "Orange")
        
        let vc = TabBarController()
        let appDelegate = UIApplication.shared.delegate! as! AppDelegate

        appDelegate.window?.rootViewController =  UINavigationController(rootViewController: vc, isTranslucent: false)
        navigationController?.navigationBar.barTintColor = UIColor(named: "Bg_black")
        appDelegate.window?.makeKeyAndVisible()
    }
    

}
