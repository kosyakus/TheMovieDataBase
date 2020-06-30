//
//  Data+Extension.swift
//  TheMovieDatabase
//
//  Created by Natali on 20.04.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation

extension Data {

    init<T>(from value: T) {
        var value = value
        self.init(buffer: UnsafeBufferPointer(start: &value, count: 1))
    }

    func to<T>(type: T.Type) -> T {
        self.withUnsafeBytes { $0.load(as: T.self) }
    }
}
