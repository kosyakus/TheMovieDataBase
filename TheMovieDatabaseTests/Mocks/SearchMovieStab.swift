//
//  SearchMovieStab.swift
//  TheMovieDatabaseTests
//
//  Created by Natali on 22.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation
@testable import TheMovieDatabase

extension Array where Element == Movie {
    
    static var stub: Self {
        return [
            Movie(
                id: 447281,
                title: "Слон и муравей",
                originalTitle: "Слон и муравей",
                voteAverage: 3,
                voteCount: 1,
                overview: "По басне народного поэта Дагестана Гамзата Цадассы.",
                poster: ""
            ),
            Movie(
                id: 139231,
                title: "Стрекоза и муравей",
                originalTitle: "Стрекоза и муравей",
                voteAverage: 6.1,
                voteCount: 14,
                overview: "",
                poster: ""
            )
        ]
    }
    
    static var stubFavorite: Self {
        return [
            Movie(
                id: 155,
                title: "The Dark Knight",
                originalTitle: "The Dark Knight",
                voteAverage: 8.4,
                voteCount: 21301,
                overview: "",
                poster: "https://image.tmdb.org/t/p/w185/qJ2tW6WMUDux911r6m7haRef0WH.jpg"
            )
        ]
    }
}
