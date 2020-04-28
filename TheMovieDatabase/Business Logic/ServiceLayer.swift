//
//  ServiceLayer.swift
//  TheMovieDatabase
//
//  Created by Natali on 21.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation
import TheMovieDatabaseAPI

final class ServiceLayer {

    // MARK: - Properties
    
    static let shared = ServiceLayer()
    
    lazy var favoriteService: FavoriteServices = FavoriteServicesImplementation(client: apiClient)
    lazy var searchMoviesService: SearchMoviesService = SearchMoviesServiceImplementation(client: apiClient)
    lazy var accountService: AccountService = AccountServicesImplementation(client: apiClient)
    lazy var loginService: LoginServices = LoginServicesImplementation(client: apiClient)
    lazy var deleteSessionService: DeleteSessionService = DeleteSessionServiceImplementation(client: apiClient)
    lazy var addMovieToFavoriteService: AddMovieToFavoriteService =
        AddMovieToFavoriteServiceImplementation(client: apiClient)
    //var session = ""
    
    // TODO: Подумать, как правильно передать сессию в адаптер.
    // Так же, сейчас каждый раз создается новый клиент, когда мы его передаем в сервис.
    // Нужно придумать, как правильно инжектить сессию и чтобы клиент инициализировался один раз.
    var apiClient: TheMovieDBAPIClient {
        TheMovieDBAPIClient(baseURL: URL(string: "https://api.themoviedb.org/3/")!,
                            apiKey: "93a57d2565c91c4db19ce6040806f41b",
                            configuration: .ephemeral)
                            //sessionId: session)
    }
}
