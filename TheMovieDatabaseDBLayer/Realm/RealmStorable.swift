//
//  RealmStorable.swift
//  TheMovieDatabaseDBLayer
//
//  Created by Natali on 12.04.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation
import RealmSwift

extension RMovie: Entity {
    public var storableArticle: StorableArticle {
        let realmAMovie = StorableArticle()
        realmAMovie.id = id
        realmAMovie.title = title ?? ""
        realmAMovie.originalTitle = originalTitle ?? ""
        realmAMovie.voteAverage = voteAverage ?? 0.0
        realmAMovie.voteCount = voteCount ?? 0
        realmAMovie.overview = overview ?? ""
        realmAMovie.poster = poster ?? ""
        realmAMovie.uuid = "\(id)"
        return realmAMovie
    }
    
    public func toStorable() -> StorableArticle {
        storableArticle
    }
}

public class StorableArticle: Object, Storable {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var originalTitle: String = ""
    @objc dynamic var voteAverage: Double = 0.0
    @objc dynamic var voteCount: Int = 0
    @objc dynamic var overview: String = ""
    @objc dynamic var poster: String =  ""
    @objc dynamic public var uuid: String = ""
    
    public var model: RMovie {
        RMovie(id: id, title: title, originalTitle: originalTitle,
               voteAverage: voteAverage, voteCount: voteCount, overview: overview, poster: poster)
    }
}
