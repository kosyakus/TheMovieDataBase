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
        guard let image = UIImage.init(named: "visibility_on_icon") else { return }
        self.setRightView(image: image)
        self.isSecureTextEntry = true
    }
    func setVisibilityOffIcon() {
        guard let image = UIImage.init(named: "visibility_off_icon") else { return }
        self.setRightView(image: image)
        self.isSecureTextEntry = false
    }
    func setBorderPuppure() {
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
