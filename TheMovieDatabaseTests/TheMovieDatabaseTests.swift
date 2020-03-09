//
//  TheMovieDatabaseTests.swift
//  TheMovieDatabaseTests
//
//  Created by Natali on 05.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import XCTest
@testable import TheMovieDatabase

class TheMovieDatabaseTests: XCTestCase {
    
    var loginUnderTests: LoginViewController!
    
    override func setUp() {
        super.setUp()
        loginUnderTests = LoginViewController()
        
    }

    override func tearDown() {
        loginUnderTests = nil
        super.tearDown()
    }

    func testValidateTextFields() {
        // 1. given
        
        // 2. when
        
        // 3. then
        //XCTAssertTrue(loginUnderTests.validateTextFields(), "Test completed successfully")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
