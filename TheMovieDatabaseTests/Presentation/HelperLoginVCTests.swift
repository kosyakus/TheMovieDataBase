//
//  HelperLoginVCTests.swift
//  TheMovieDatabaseTests
//
//  Created by Natali on 23.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

@testable import TheMovieDatabase
import XCTest

final class HelperLoginVCTests: XCTestCase {
    
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
        XCTAssertTrue(validation)
    }
    
}
