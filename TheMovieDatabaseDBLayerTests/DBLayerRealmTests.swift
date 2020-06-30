//
//  DBLayerRealmTests.swift
//  TheMovieDatabaseDBLayerTests
//
//  Created by Natali on 14.04.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import RealmSwift
@testable import TheMovieDatabaseDBLayer
import XCTest

class DBLayerRealmTests: XCTestCase {

    override func setUp() {
        super.setUp()
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
    }

    override func tearDown() {
        super.tearDown()
    }
    
    private func createRepository() -> AnyRepository<RMovie> {
        AnyRepository()
    }

    func testInsertMovieLocally() {
        let movie = RMovie(id: 55, title: "some movie title",
                           originalTitle: "some movie original title", voteAverage: 5.5,
                           voteCount: 6999, overview: "some text", poster: nil)
        let repository = createRepository()
        
        try? repository.insert(item: movie)
        let savedItems: [RMovie] = repository.getAll()
        
        XCTAssertEqual(1, savedItems.count)
    }
    
    func testUpdateMovie() {
        var movie = RMovie(id: 55, title: "some movie title",
                           originalTitle: "some movie original title", voteAverage: 5.5,
                           voteCount: 6999, overview: "some text", poster: nil)
        let repository = createRepository()
        try? repository.insert(item: movie)
        
        movie.voteAverage = 6.6
        
        try? repository.update(item: movie)
        
        let savedItems: [RMovie] = repository.getAll()
        
        XCTAssertEqual(6.6, savedItems.first!.voteAverage)
    }

    func testDeleteMovie() {
        let movie = RMovie(id: 55, title: "some movie title",
                           originalTitle: "some movie original title", voteAverage: 5.5,
                           voteCount: 6999, overview: "some text", poster: nil)
        let repository = createRepository()
        try? repository.insert(item: movie)
        
        try? repository.delete(item: movie)
        
        let savedItems: [RMovie] = repository.getAll()
        
        XCTAssertEqual(0, savedItems.count)
    }

    func test_getAll_filters_items() {
        let movie = RMovie(id: 55, title: "some movie title",
                           originalTitle: "some movie original title", voteAverage: 5.5,
                           voteCount: 6999, overview: "some text", poster: nil)
        let movie2 = RMovie(id: 66, title: "some other movie title",
                            originalTitle: "some movie original title", voteAverage: 5.5,
                            voteCount: 6999, overview: "some text", poster: nil)
        
        let repository = createRepository()
        try? repository.insert(item: movie)
        try? repository.insert(item: movie2)
        
        let savedItems: [RMovie] = repository
            .getAll(where: NSPredicate(format: "title = %@", movie2.title!))
        
        XCTAssertEqual(1, savedItems.count)
    }

}
