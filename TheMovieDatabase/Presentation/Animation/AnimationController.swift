//
//  AnimationController.swift
//  TheMovieDatabase
//
//  Created by Natali on 10.04.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation
import UIKit

class AnimationController {
    
    func makeLightEmitterCell() -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.birthRate = 1
        cell.lifetime = 1.0
        cell.scale = 0.35
        cell.alphaSpeed = -0.5
        let wheelImage = "ufo_light_image"
        cell.contents = UIImage(named: wheelImage)?.cgImage
        return cell
    }
    
    func makeGhostEmitterCell() -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.birthRate = 1
        cell.lifetime = 1.0
        cell.scale = 0.35
        cell.velocity = 10
        //cell.velocityRange = 15
        //cell.emissionRange = 5
        
        let pipeImage = "ufo_ghost_image"
        cell.contents = UIImage(named: pipeImage)?.cgImage
        return cell
    }
    
    func makePlateEmitterCell() -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.birthRate = 1
        cell.lifetime = 1.0
        cell.scale = 0.35
        cell.velocity = 10
        cell.emissionLongitude = .pi
        
        let pipeImage = "ufo_plate"
        cell.contents = UIImage(named: pipeImage)?.cgImage
        return cell
    }
    
    /// Methods for FavoriteMovies ViewController
    
    func makeWheelEmitterCell(color: UIColor) -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.birthRate = 1
        cell.lifetime = 1.0
        cell.scale = 0.35
        cell.color = color.cgColor
        cell.spin = 1
        let wheelImage = "wheel_image"
        cell.contents = UIImage(named: wheelImage)?.cgImage
        return cell
    }
    
    func makePipeEmitterCell(color: UIColor) -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.birthRate = 1
        cell.lifetime = 1.0
        cell.scale = 0.35
        cell.color = color.cgColor
        cell.velocity = 10
        cell.autoreverses = true
        let pipeImage = "pipe_image"
        cell.contents = UIImage(named: pipeImage)?.cgImage
        return cell
    }
    
    func makeOtherEmitterCell(image: String) -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.birthRate = 1
        cell.lifetime = 1.0
        cell.scale = 0.35
        cell.contents = UIImage(named: image)?.cgImage
        return cell
    }
    
    func makePopcornEmitterCell(image: String) -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.birthRate = 3
        cell.lifetime = 1.0
        cell.lifetimeRange = 0
        cell.scale = 0.35
        cell.velocity = 100
        cell.velocityRange = 50
        cell.emissionLongitude = 1
        cell.emissionRange = 100
        cell.contents = UIImage(named: image)?.cgImage
        return cell
    }
    
//    private func rotateFilm() {
//        let wheelImage = UIImageView()
//        let wheel = "wheel_image"
//        wheelImage.image = UIImage(named: wheel)
//        wheelImage.bounds = noMovieView.bounds
//        wheelImage.center.x = noMovieView.center.x
//        wheelImage.center.y = noMovieView.center.y
//        let rotation = CABasicAnimation(keyPath: "transform.rotation")
//        rotation.toValue = Double.pi * 2
//        rotation.duration = 8
//        rotation.repeatCount = .infinity
//        wheelImage.layer.add(rotation, forKey: "rotation")
//        view.layer.addSublayer(wheelImage.layer)
//    }
    
}
