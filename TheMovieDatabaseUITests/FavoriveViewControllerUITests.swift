//
//  FavoriveViewControllerUITests.swift
//  TheMovieDatabaseUITests
//
//  Created by Natali on 23.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Catbird
@testable import TheMovieDatabase
import XCTest

final class FavoriveViewControllerUITests: XCTestCase {
    
    private let catbird = Catbird()
    private var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        
        let url = catbird.url
        app.launchArguments = ["-url_key", url.absoluteString]
//        XCTAssertNoThrow(try catbird.send(Command.add(
//            pattern: FavoriteMovieAPIMock().pattern,
//            data: FavoriteMovieAPIMock().responseData
//        )))
        
        app.launch()
    }
    
    override func tearDown() {
        //XCTAssertNoThrow(try catbird.send(.clear), "Remove all requests")
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
    
//    func testLogin() {
//        XCTAssertNoThrow(try catbird.send(.add(FavoriteMovieAPIMock.success)))
//
//        app.textFields["FindMovieTF"].tap()
//        app.textFields["FindMovieTF"].typeText("муравей")
//
//        wait(forElement: app.staticTexts[""])
//    }
    
}
