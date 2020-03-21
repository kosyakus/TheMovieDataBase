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
    //let userService = UserService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    // MARK: - Public methods
    
    func setUpView() {
        self.hideKeyboardWhenTappedAround()
        errorLabel.isHidden = true
        passwordTextField.setVisibilityOnIcon()
        enterButton.layer.cornerRadius = 0.02 * enterButton.bounds.size.width
        loginTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        loginTextField.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .allTouchEvents)
        passwordTextField.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .allTouchEvents)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if HelperLoginVC().validate(login: loginTextField.text, password: passwordTextField.text) {
            enterButton.titleLabel?.textColor = UIColor(named: "Light")
            enterButton.backgroundColor = UIColor.CustomColor.orange
        } else {
            enterButton.titleLabel?.textColor = UIColor.CustomColor.gray
            enterButton.backgroundColor = UIColor.CustomColor.lightGray
        }
    }
    
    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == loginTextField {
            loginTextField.setBorderPuppure()
            passwordTextField.setBorderClear()
        } else {
            loginTextField.setBorderClear()
            passwordTextField.setBorderPuppure()
        }
    }
    
    func sendApiRequest(login: String, password: String) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        LoginService.parseTokenFromJson { token in
            print("Token \(token.token)")
            LoginService.validateToken(username: login,
                                       password: password,
                                       requestToken: token.token) {_ in
                print("validated")
                LoginService.parseSessionFromJson(requestToken: token.token) { session in
                        print("Session \(session)")
                        try? ManageKeychain().saveSessionId(sessionId: session.sessionId,
                                                            user: KeychainUser(username: login))
                        appDelegate?.presentViewController()
                }
            }
        }
    }
    
    // MARK: - IBAction
    
    @IBAction func tapEnterButton(_ sender: Any) {
        guard HelperLoginVC().validate(login: loginTextField.text, password: passwordTextField.text) else { return }
         guard let login = loginTextField.text,
         let password = passwordTextField.text
         else { return }
         sendApiRequest(login: login, password: password)
    }
}
