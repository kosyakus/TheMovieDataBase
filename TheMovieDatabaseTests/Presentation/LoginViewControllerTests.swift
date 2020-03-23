//
//  LoginViewControllerTests.swift
//  TheMovieDatabaseTests
//
//  Created by Natali on 23.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation
@testable import TheMovieDatabase
import XCTest

final class LoginViewControllerTests: ViewControllerTestCase {
    
    var loginViewController: LoginViewController { rootViewController as! LoginViewController}

    override func setUp() {
        super.setUp()
        rootViewController = LoginViewController()
    }

    /// Тесты на появление текстовых полей
    func testLoginTextFieldExists() {
        let loginTextField = loginViewController.loginTextField
        XCTAssertNotNil(loginTextField)
    }
    
    func testPasswordTextFieldExists() {
        let passwordTextField = loginViewController.passwordTextField
        XCTAssertNotNil(passwordTextField)
    }
    
    /// Тест на появление кнопки входа
    func testLoginButtonExists() {
        let loginButton = loginViewController.enterButton
        XCTAssertNotNil(loginButton)
    }
    
    func testErrorLabelExists() {
        XCTAssertTrue(loginViewController.errorLabel.isHidden)
    }
    
}
