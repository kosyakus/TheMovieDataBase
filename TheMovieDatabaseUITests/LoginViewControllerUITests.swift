//
//  LoginViewControllerUITests.swift
//  TheMovieDatabaseUITests
//
//  Created by Natali on 23.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

@testable import TheMovieDatabase
import XCTest

final class LoginViewControllerUITests: XCTestCase {
    private var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        
        app.launch()
    }

    override func tearDown() {
        super.tearDown()
    }

    /// Тест на доступность кнопки при заполнении полей
    func testLoginButtonEnabled() {
        
        //app.textFields["LoginTF"].typeText("abc")
        //app.secureTextFields["PassTF"].typeText("abc")
        /// TODO: как-то скрыть клавиатуру
        XCTAssertTrue(app.buttons["loginButton"].isHittable)
    }
    
    /// Тест на наличие placeholders
    func testLoginPlaceholderExists() {
        XCTAssertEqual(app.textFields["LoginTF"].placeholderValue, "Логин")
    }
    
    func testPasswordPlaceholderExists() {
        XCTAssertEqual(app.secureTextFields["PassTF"].placeholderValue, "Пароль")
    }
    
}
