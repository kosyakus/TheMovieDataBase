//
//  FavoriteMovieAPIMock.swift
//  TheMovieDatabaseUITests
//
//  Created by Natali on 23.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Catbird
import XCTest

class FavoriteMovieAPIMock: RequestBagConvertible {
    var pattern: RequestPattern {
        RequestPattern.get(URL(string: "/search/movie")!)
    }
    
    var responseData: ResponseData {
        if let path = Bundle(for: type(of: self)).path(forResource: "SearchMovies", ofType: "json") {
            if let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped) {
                return ResponseData(statusCode: 200, headerFields: [:], body: jsonData)
             }
        }
        
        return ResponseData(statusCode: 200, headerFields: [:], body: nil)
    }
}
