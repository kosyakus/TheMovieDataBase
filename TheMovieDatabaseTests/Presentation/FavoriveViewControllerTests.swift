//
//  FavoriveViewControllerTests.swift
//  TheMovieDatabaseTests
//
//  Created by Natali on 22.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation
@testable import TheMovieDatabase
import XCTest

final class FavoriveViewControllerTests: ViewControllerTestCase {
    
    var favoriteViewController: FavoriveViewController { rootViewController as! FavoriveViewController }

    override func setUp() {
        super.setUp()
        let favoriteViewController = FavoriveViewController()
        favoriteViewController.favoriteService = FavoriteMock(movies: .stubFavorite)
        rootViewController = favoriteViewController
    }
    
    /// Тест на появление на экране картинки с попкорном
    func testImageViewAppear() throws {
        let imageView = try XCTUnwrap(favoriteViewController.noMovieView)
        XCTAssertEqual(imageView.image, UIImage(named: "no_movie"))
    }
    
    /// Тесты на наличие кнопки поиска фильмов
    func testSearchButtonExists() {
        XCTAssertNotNil(favoriteViewController.findMoviesButton.isEnabled)
    }

}
