//
//  FavoriveViewControllerUITests.swift
//  TheMovieDatabaseUITests
//
//  Created by Natali on 23.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

@testable import TheMovieDatabase
import XCTest

final class FavoriveViewControllerUITests: XCTestCase {
    
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
    
    /// Тест на появление кнопки на экране
    func testFindMovieButtonExists() throws {
        let currentScreen = app.navigationBars.element
        guard currentScreen.identifier == "TheMovieDatabase.TabBar" else { return }
        app.buttons["Избранное"].tap()
        let button = app.buttons["FindMovieButton"]
        XCTAssertTrue(button.isHittable)
    }
    
}
