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
    @IBOutlet weak var errorLabel: UILabel!
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
        
        setUpView()
        
    }
    
    
    // MARK: - Public methods
    
    func setUpView() {
        self.hideKeyboardWhenTappedAround()
        errorLabel.isHidden = true
        passwordTextField.addTap()
        passwordTextField.setVisibilityOnIcon()
        enterButton.layer.cornerRadius = 0.02 * enterButton.bounds.size.width
        loginTextField.addTarget(self, action: #selector(LoginViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        passwordTextField.addTarget(self, action: #selector(LoginViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if HelperLoginVC().validate(login: loginTextField.text, password: passwordTextField.text) {
            enterButton.titleLabel?.textColor = UIColor(named: "Light")
            enterButton.backgroundColor = UIColor(named: "Orange")
        } else {
            enterButton.titleLabel?.textColor = UIColor(named: "Gray")
            enterButton.backgroundColor = UIColor(named: "LightGray")
        }
    }
    
    // MARK: - IBAction
    
    @IBAction func tapEnterButton(_ sender: Any) {
        guard HelperLoginVC().validate(login: loginTextField.text, password: passwordTextField.text) else { return }
        guard let login = loginTextField.text,
            let password = passwordTextField.text
            else { return }
        let appDelegate = UIApplication.shared.delegate! as! AppDelegate
        userService.createToken(username: login, password: password) {
            print("token created")
            appDelegate.presentViewController()
        }
    }
    
    
}
