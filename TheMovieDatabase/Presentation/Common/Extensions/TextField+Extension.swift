//
//  TextFieldExtension.swift
//  TheMovieDatabase
//
//  Created by Natali on 07.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    func setRightView(image: UIImage) {
        let iconView = UIImageView(frame: CGRect(x: 0, y: 10, width: 24, height: 24))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 45))
        iconContainerView.addSubview(iconView)
        rightView = iconContainerView
        rightViewMode = .always
        self.addTap()
    }
    
    func setLeftView(image: UIImage) {
        let iconView = UIImageView(frame: CGRect(x: 10, y: 10, width: 24, height: 24))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 45))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }
    
    func addTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.rightView?.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        if self.isSecureTextEntry {
            setVisibilityOffIcon()
        } else {
            setVisibilityOnIcon()
        }
    }
    
    func setVisibilityOnIcon() {
        self.setRightView(image: #imageLiteral(resourceName: "visibility_on_icon"))
        self.isSecureTextEntry = true
    }
    
    func setVisibilityOffIcon() {
        self.setRightView(image: #imageLiteral(resourceName: "visibility_off_icon"))
        self.isSecureTextEntry = false
    }
    
    @objc func setBorderPuppure() {
        self.layer.borderColor = UIColor(named: "Purpure")?.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 0.02 * self.bounds.size.width
    }
    
    func setBorderClear() {
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 0.02 * self.bounds.size.width
    }
}

extension UITextField {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}

class AuthField: UITextField {
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) ||
            action == #selector(UIResponderStandardEditActions.copy(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
}
