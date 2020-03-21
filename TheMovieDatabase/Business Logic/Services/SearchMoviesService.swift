//
//  SearchMoviesService.swift
//  TheMovieDatabase
//
//  Created by Natali on 21.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Alamofire
import Foundation

public class SearchMoviesService {
    
    // MARK: - Private Properties
    
    private static let apiKey = "93a57d2565c91c4db19ce6040806f41b"
    
    static public func getMoviesList(language: String,
                                     query: String,
                                     completion: @escaping (AFResult<Movies>) -> Void) {
        APIClient.performRequest(route: SearchMoviesEndpoint.getMoviesList(language: language,
                                                                           query: query,
                                                                           apiKey: apiKey),
                                 completion: completion)
    }
    
    static public func parseMoviesFromJson(language: String, query: String, completion: @escaping (Movies) -> Void) {
        SearchMoviesService.getMoviesList(language: language, query: query) { result in
            switch result {
            case .success(let movie):
                completion(movie)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
