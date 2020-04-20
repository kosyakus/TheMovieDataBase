//
//  UIColorExtension.swift
//  TheMovieDatabase
//
//  Created by Natali on 13.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    struct CustomColor {
        static let bgBlack = UIColor(named: "Bg_black")
        static let darkBlue = UIColor(named: "DarkBlue")
        static let gray = UIColor(named: "Gray")
        static let light = UIColor(named: "Light")
        static let lightGray = UIColor(named: "LightGray")
        static let orange = UIColor(named: "Orange")
        static let purpure = UIColor(named: "Purpure")
        static let red = UIColor(named: "Red")
    }
    
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
