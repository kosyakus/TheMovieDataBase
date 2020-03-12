//
//  User.swift
//  TheMovieDatabase
//
//  Created by Natali on 09.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class User: Object, Decodable, Encodable {
    @objc dynamic var sessionId = ""
    @objc dynamic var login = ""
    @objc dynamic var name: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var icon: String = ""
}
