//
//  MainViewControllerUITests.swift
//  TheMovieDatabaseUITests
//
//  Created by Natali on 23.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Catbird
@testable import TheMovieDatabase
import XCTest

class MainViewControllerUITests: XCTestCase {

    private let catbird = Catbird()
    private var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        
        let url = catbird.url
        app.launchArguments = ["-url_key", url.absoluteString]
        
        app.launch()
    }
    
    override func tearDown() {
        XCTAssertNoThrow(try catbird.send(.clear), "Remove all requests")
        super.tearDown()
    }

    /// Тест на наличие placeholders
    func testLoginPlaceholderExists() {
        XCTAssertEqual(app.textFields["FindMovieTF"].placeholderValue, "Поиск фильмов")
    }
    
    /// Тест на появление клавиатуры
    func testKeyboardAppearsOnTap() {
        app.textFields["FindMovieTF"].tap()
        // swiftlint:disable empty_count
        XCTAssert(app.keyboards.count > 0)
    }
    
    /// Тест на поиск фильмов. Когда доделаю апи поиска- должен заработать. А еще список на экране нужно отобразить
    
    func testSearchMovies() {
        XCTAssertNoThrow(try catbird.send(Command.add(
            pattern: FavoriteMovieAPIMock().pattern,
            data: FavoriteMovieAPIMock().responseData
        )))
    }
    
}
