//
//  Model.swift
//  TheMovieDatabaseDBLayer
//
//  Created by Natali on 12.04.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import CoreData
import Foundation

/// For CoreData:

extension RMovie: CDEntity {
    public func toStorable(in context: NSManagedObjectContext) -> CDMovie {
        let coreDataMovie = CDMovie.getOrCreateSingle(with: title!, from: context)
        coreDataMovie.id = id
        coreDataMovie.title = title
        coreDataMovie.originalTitle = originalTitle
        coreDataMovie.voteAverage = voteAverage ?? 0.0
        coreDataMovie.voteCount = voteCount ?? 0
        coreDataMovie.overview = overview
        coreDataMovie.poster = poster
        return coreDataMovie
    }
}

@objc(CDMovie)
public class CDMovie: NSManagedObject {

}

extension CDMovie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDMovie> {
        NSFetchRequest<CDMovie>(entityName: "CDMovie")
    }

    @NSManaged public var id: Int
    @NSManaged public var title: String?
    @NSManaged public var originalTitle: String?
    @NSManaged public var voteAverage: Double
    @NSManaged public var voteCount: Int
    @NSManaged public var overview: String?
    @NSManaged public var poster: String?
    @NSManaged public var uuid: String
}

extension CDMovie: CDStorable {
    public var model: RMovie {
        RMovie(id: id, title: title, originalTitle: originalTitle,
               voteAverage: voteAverage, voteCount: voteCount, overview: overview, poster: poster)
    }
}
