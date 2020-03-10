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
    
    var validationUnderTests: HelperLoginVC!
    
    override func setUp() {
        super.setUp()
        validationUnderTests = HelperLoginVC()
        
    }

    override func tearDown() {
        validationUnderTests = nil
        super.tearDown()
    }

    func testValidateTextFields() {
        // 1. given
        let login = "txt"
        let pass = "txt"
        // 2. when
        let validation = validationUnderTests.validate(login: login, password: pass)
        
        // 3. then
        XCTAssertTrue(validation, "Test completed successfully")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
