//
//  PrivacyProtectionViewController.swift
//  TheMovieDatabase
//
//  Created by Natali on 20.04.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import UIKit

class PrivacyProtectionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
    }
}
