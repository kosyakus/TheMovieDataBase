//
//  UIImageViewExtension.swift
//  TheMovieDatabase
//
//  Created by Natali on 29.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation
import  UIKit

extension UIImageView {
    
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            guard let data = try? Data(contentsOf: url) else { return }
            guard let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
}
