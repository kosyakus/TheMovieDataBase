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

class User: Object {
    
    dynamic var name: String = ""
    dynamic var email: String = ""
    dynamic var icon: String = ""
    
    convenience init?(_ json: JSON) {
        
        guard
        let name = json["dt_txt"].string,
        let email = json["weather"][0]["description"].string,
        let icon = json["weather"][0]["icon"].string
        else { return nil }
        
        self.init()
        self.name = name
        self.email = email
        self.icon = "http://openweathermap.org/img/w/" + icon + ".png"
        
    }
    
}
