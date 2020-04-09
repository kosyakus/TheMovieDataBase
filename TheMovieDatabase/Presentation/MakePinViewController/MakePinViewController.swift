//
//  MakePinViewController.swift
//  TheMovieDatabase
//
//  Created by Natali on 04.04.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import UIKit

class MakePinViewController: UIViewController {
    
    public enum State {
        case inactive
        case active
        case error
    }
    
    @IBOutlet weak var pinSuggestionsLabel: UILabel!
    @IBOutlet weak var wrongPinLabel: UILabel!
    @IBOutlet var numberButton: [UIButton]!
    @IBOutlet var pinViewsCollection: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        for button in numberButton {
            button.layer.cornerRadius = button.bounds.size.height / 2
        }
        for pin in pinViewsCollection {
            pin.layer.cornerRadius = pin.bounds.size.height / 2
        }
        //backgroundColor = inactiveColor
    }
}
