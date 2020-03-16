//
//  StringExtension.swift
//  TheMovieDatabase
//
//  Created by Natali on 16.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation
import UIKit

extension String {
    var toUIImage: UIImage? {
        var img = self
        img = String(img.map({ $0 == "\r" ? " " : $0 }))
        img = String(img.map({ $0 == "\n" ? " " : $0 }))
        img = String(img.map({ $0 == "\r\n" ? " " : $0 }))
        let dataDecoded: NSData? = NSData(base64Encoded: img,
                                          options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)
        return UIImage(data: dataDecoded! as Data)
    }
}
