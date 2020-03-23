//
//  MainViewControllerUITests.swift
//  TheMovieDatabaseUITests
//
//  Created by Natali on 23.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

@testable import TheMovieDatabase
import XCTest

class MainViewControllerUITests: XCTestCase {

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

    /// Тест на наличие placeholders
    func testLoginPlaceholderExists() {
        XCTAssertEqual(app.textFields["FindMovieTF"].placeholderValue, "Поиск фильмов")
    }
    
}
