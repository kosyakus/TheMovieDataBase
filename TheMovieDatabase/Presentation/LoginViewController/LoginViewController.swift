//
//  LoginViewController.swift
//  TheMovieDatabase
//
//  Created by Natali on 06.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import UIKit

import TheMovieDatabaseAPI

class LoginViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Public Properties
    
    var loginService: LoginServices
    let loginButton = UIButton()
    let loadingViewController = LoadingViewController()
    var activeTextField = UITextField()
    
    // MARK: - Initializers
    
    init(loginService: LoginServices = ServiceLayer.shared.loginService) {
        self.loginService = loginService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
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
        passwordTextField.setVisibilityOnIcon()
        enterButton.layer.cornerRadius = 0.02 * enterButton.bounds.size.width
        loginTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        loginTextField.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .allTouchEvents)
        passwordTextField.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .allTouchEvents)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        setUpButton()
    }
    
    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == loginTextField {
            loginTextField.setBorderPuppure()
            passwordTextField.setBorderClear()
        } else {
            loginTextField.setBorderClear()
            passwordTextField.setBorderPuppure()
        }
        setUpButton()
        self.activeTextField = textField
    }
    
    func setUpButton() {
        if HelperLoginVC().validate(login: loginTextField.text, password: passwordTextField.text) {
            enterButton.titleLabel?.textColor = UIColor(named: "Light")
            enterButton.backgroundColor = UIColor.CustomColor.orange
        } else {
            enterButton.titleLabel?.textColor = UIColor.CustomColor.gray
            enterButton.backgroundColor = UIColor.CustomColor.lightGray
        }
    }
    
    /// Обработка экрана при появлении клавиатуры
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = keyboardSize.cgRectValue
        buttonBottomConstraint.constant = keyboardFrame.height + 5
        enterButton.setNeedsLayout()
    }
    
    /// Обработка экрана при скрытии клавиатуры
    @objc func keyboardWillHide(notification: NSNotification) {
        buttonBottomConstraint.constant = 0.0
        enterButton.setNeedsLayout()
    }
    
    func sendApiRequest(login: String, password: String) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        loginService.fetchToken(login: login, password: password) { _ in
            self.remove()
            appDelegate?.presentViewController()
        }
        activeTextField.shake()
        loadingViewController.remove()
    }
    
    // MARK: - IBAction
    
    @IBAction func tapEnterButton(_ sender: Any) {
        guard HelperLoginVC().validate(login: loginTextField.text, password: passwordTextField.text) else { return }
        guard let login = loginTextField.text,
            let password = passwordTextField.text
            else { return }
        add(loadingViewController)
        sendApiRequest(login: login, password: password)
    }
}

extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}
