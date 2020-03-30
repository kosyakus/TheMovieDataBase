//
//  Movie.swift
//  TheMovieDatabase
//
//  Created by Natali on 22.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation

struct Movie {
    let id: Int
    let title: String?
    let originalTitle: String?
    let voteAverage: Double?
    let voteCount: Int?
    let overview: String?
    let poster: URL?
}
