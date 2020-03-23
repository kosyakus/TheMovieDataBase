//
//  UIView+Extension.swift
//  TheMovieDatabaseTests
//
//  Created by Natali on 22.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import UIKit

extension UIView {
    
    func subview<T: UIView>(withAccessibilityIdentifier accessibilityIdentifier: String) -> T? {
        if self.accessibilityIdentifier == accessibilityIdentifier { return self as? T }
        
        for subview in subviews {
            if let view = subview.subview(withAccessibilityIdentifier: accessibilityIdentifier) {
                return view as? T
            }
        }
        
        return nil
    }
}
