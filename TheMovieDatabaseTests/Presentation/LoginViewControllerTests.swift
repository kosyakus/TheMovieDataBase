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
    
    var loginViewController: LoginViewController { rootViewController as! LoginViewController }

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
    
    /// Тест на наличие скрытого текста ошибки
    func testErrorLabelExists() {
        XCTAssertTrue(loginViewController.errorLabel.isHidden)
    }
    
    /// Тест на наличие иконки в password textfield
    func checkVisibilityIconOff() {
        loginViewController.setUpView()
        XCTAssertNotNil(loginViewController.passwordTextField.rightView)
    }
    
    /// Тест на изменение цвета кнопки при заполнении полей
    func testButtonChangedColor() {
        loginViewController.loginTextField.text = "txt"
        loginViewController.passwordTextField.text = "txt"
        loginViewController.textFieldDidChange(loginViewController.loginTextField)
        XCTAssertEqual(loginViewController.enterButton.backgroundColor, UIColor.CustomColor.orange, "not equal")
    }
    
    /// Тест на изменение цвета кнопки при заполнении только одного поля
    func testButtonNotChangedColor() {
        loginViewController.loginTextField.text = "txt"
        loginViewController.textFieldDidChange(loginViewController.loginTextField)
        XCTAssertEqual(loginViewController.enterButton.backgroundColor, UIColor.CustomColor.lightGray, "not equal")
    }
    
    /// Тест на изменение цвета шрифта кнопки при заполнении полей
    func testButtonChangedTintColor() {
        loginViewController.loginTextField.text = "txt"
        loginViewController.passwordTextField.text = "txt"
        loginViewController.textFieldDidChange(loginViewController.loginTextField)
        XCTAssertNotEqual(loginViewController.enterButton.titleLabel?.textColor, UIColor.CustomColor.light, "equal")
    }
    
    /// Тест на изменение цвета шрифта кнопки при заполнении только одного поля
    func testButtonNotChangedTintColor() {
        loginViewController.loginTextField.text = "txt"
        loginViewController.textFieldDidChange(loginViewController.loginTextField)
        XCTAssertNotEqual(loginViewController.enterButton.titleLabel?.textColor, UIColor.CustomColor.gray, "equal")
    }
    
    /// Тест на изменение рамки поля логина
    func testLoginTextFieldChangedFrameColor() {
        let mockTF = TextFieldMock()
        loginViewController.loginTextField = mockTF
        loginViewController.loginTextField.text = "txt"
        loginViewController.textFieldDidBeginEditing(loginViewController.loginTextField)
        loginViewController.loginTextField.setBorderPuppure()
        XCTAssertTrue(mockTF.borderChanged, "not true")
    }
    
    /// Тест на изменение рамки поля пароля
    func testPassTextFieldChangedFrameColor() {
        let mockTF = TextFieldMock()
        loginViewController.passwordTextField = mockTF
        loginViewController.passwordTextField.text = "txt"
        loginViewController.textFieldDidBeginEditing(loginViewController.passwordTextField)
        loginViewController.passwordTextField.setBorderPuppure()
        XCTAssertTrue(mockTF.borderChanged, "not true")
    }
    
}

// Mock code
class TextFieldMock: UITextField {
    var borderChanged = false
    override func setBorderPuppure() {
        borderChanged = true
    }
}
