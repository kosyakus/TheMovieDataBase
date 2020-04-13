//
//  RealmModel.swift
//  TheMovieDatabaseDBLayer
//
//  Created by Natali on 12.04.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation
import RealmSwift

/// For Realm

public struct RMovie {
    public var id: Int
    public var title: String?
    public var originalTitle: String?
    public var voteAverage: Double?
    public var voteCount: Int?
    public var overview: String?
    public var poster: Data?
    
    public init(id: Int, title: String?, originalTitle: String?,
                voteAverage: Double?, voteCount: Int?, overview: String?, poster: Data?) {
        self.id = id
        self.title = title
        self.originalTitle = originalTitle
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.overview = overview
        self.poster = poster

    }
}
