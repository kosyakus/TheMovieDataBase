//
//  MainViewControllerTests.swift
//  TheMovieDatabaseTests
//
//  Created by Natali on 22.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

@testable import TheMovieDatabase
import XCTest

final class MainViewControllerTests: ViewControllerTestCase {
    
    var viewController: MainViewController { rootViewController as! MainViewController }

    override func setUp() {
        super.setUp()
        let mainViewController = MainViewController()
        mainViewController.searchMoviesService = SearchMovieMock(movies: .stub)
        rootViewController = mainViewController
    }
    
}
