//
//  ProfileViewControllerTests.swift
//  TheMovieDatabaseTests
//
//  Created by Natali on 25.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation
@testable import TheMovieDatabase
import XCTest

class ProfileViewControllerTests: ViewControllerTestCase {

    var profileViewController: ProfileViewController { rootViewController as! ProfileViewController }

    override func setUp() {
        super.setUp()
        let profileViewController = ProfileViewController()
        rootViewController = profileViewController
    }
    
    /// Тест на появление на экране картинки аватара
    func testImageViewAppear() throws {
        let imageView = try XCTUnwrap(profileViewController.avatarImageView)
        XCTAssertEqual(imageView.image, UIImage(named: "avatar"))
    }
    
    /// Тесты на наличие email лейбла
    func testEmailLabelExists() {
        XCTAssertNotNil(profileViewController.emailLabel.isEnabled)
    }
    
    /// Тесты на наличие логин лейбла
    func testLoginLabelExists() {
        XCTAssertNotNil(profileViewController.nameLabel.isEnabled)
    }

}
