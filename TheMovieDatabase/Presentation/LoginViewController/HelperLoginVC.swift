//
//  HelperLoginVC.swift
//  TheMovieDatabase
//
//  Created by Natali on 10.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation

class HelperLoginVC {
    func validate(login: String?, password: String?) -> Bool {
        guard login != "", password != "" else { return false }
        return true
    }
}
