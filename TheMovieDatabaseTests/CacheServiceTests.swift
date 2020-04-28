//
//  CacheServiceTests.swift
//  TheMovieDatabaseTests
//
//  Created by Natali on 26.04.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

@testable import TheMovieDatabaseAPI
import XCTest

class CacheServiceTests: XCTestCase {
  let service = CacheService()

  override func setUp() {
    super.setUp()

    try? service.clear()
  }

  func testClear() {
    let expectation = self.expectation(description: #function)
    let string = "Some string"
    let data = string.data(using: .utf8)!

    service.save(data: data, key: "key", completion: {
      try? self.service.clear()
      self.service.load(key: "key", completion: {
        XCTAssertNil($0)
        expectation.fulfill()
      })
    })

    wait(for: [expectation], timeout: 1)
  }

  func testSave() {
    let expectation = self.expectation(description: #function)
    let string = "Some string"
    let data = string.data(using: .utf8)!

    service.save(data: data, key: "key")
    service.load(key: "key", completion: {
      XCTAssertEqual($0, data)
      expectation.fulfill()
    })

    wait(for: [expectation], timeout: 1)
  }
}
