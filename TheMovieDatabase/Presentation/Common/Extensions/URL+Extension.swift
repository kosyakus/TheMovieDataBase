//
//  URL+Extension.swift
//  TheMovieDatabase
//
//  Created by Natali on 13.04.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation

extension URL {
    
    func convertUrlToData() -> Data {
        let data = Data()
        guard let imageData = try? Data(contentsOf: self) else { return data }
        return imageData
    }
}
