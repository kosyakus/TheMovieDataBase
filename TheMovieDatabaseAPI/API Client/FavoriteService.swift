//
//  FavoriteService.swift
//  TheMovieDatabaseAPI
//
//  Created by Natali on 17.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Alamofire
import Foundation

public class FavoriteService {
    
    // MARK: - Private Properties
    
    private static let apiKey = "93a57d2565c91c4db19ce6040806f41b"
    
    static public func getFavoriteMoviesList(session: String,
                                             completion: @escaping (AFResult<Movies>) -> Void) {
        APIClient.performRequest(route: FavoriteEndpoint.getFavoriteList(session: session,
                                                                         apiKey: apiKey),
                                 completion: completion)
    }
    
    static public func parseMoviesFromJson(session: String, completion: @escaping (Movies) -> Void) {
        FavoriteService.getFavoriteMoviesList(session: session) { result in
            switch result {
            case .success(let movies):
                completion(movies)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
