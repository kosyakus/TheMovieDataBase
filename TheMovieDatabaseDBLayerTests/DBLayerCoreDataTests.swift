//
//  DBLayerCoreDataTests.swift
//  TheMovieDatabaseDBLayerTests
//
//  Created by Natali on 14.04.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import CoreData
@testable import TheMovieDatabaseDBLayer
import XCTest

class DBLayerCoreDataTests: XCTestCase {

    override func setUp() {
        super.setUp()
        //CoreData.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
    }

    override func tearDown() {
        super.tearDown()
    }
    
    private func createRepository() -> CoreDataRepository<RMovie> {
        CoreDataRepository(persistentContainer: CoreDataHelper().persistentContainer)
    }

    func testInsertMovieLocally() {
        let movie = RMovie(id: 55, title: "some movie title",
                           originalTitle: "some movie original title", voteAverage: 5.5,
                           voteCount: 6999, overview: "some text", poster: nil)
        let repository = createRepository()
        
        try? repository.insert(item: movie)
        guard let savedItems: [RMovie] = try? repository.getAll() else { return }
        
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
        
        guard let savedItems: [RMovie] = try? repository.getAll() else { return }
        
        XCTAssertEqual(6.6, savedItems.first!.voteAverage)
    }

    func testDeleteMovie() {
        let movie = RMovie(id: 55, title: "some movie title",
                           originalTitle: "some movie original title", voteAverage: 5.5,
                           voteCount: 6999, overview: "some text", poster: nil)
        let repository = createRepository()
        try? repository.insert(item: movie)
        
        try? repository.delete(item: movie)
        
        guard let savedItems: [RMovie] = try? repository.getAll() else { return }
        
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
        
        guard let savedItems: [RMovie] = try? repository.getAll(where:
            NSPredicate(format: "title = %@", movie2.title!)) else { return }
        
        XCTAssertEqual(1, savedItems.count)
    }

}
