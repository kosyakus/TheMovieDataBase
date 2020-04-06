//
//  ProfileViewController.swift
//  TheMovieDatabase
//
//  Created by Natali on 07.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    // MARK: - Private Properties
    
    private let accountService: AccountService
    private let deleteSessionService: DeleteSessionService
    
    // MARK: - Initializers
    
    init(accountService: AccountService = ServiceLayer.shared.accountService,
         deleteSessionService: DeleteSessionService = ServiceLayer.shared.deleteSessionService) {
        self.accountService = accountService
        self.deleteSessionService = deleteSessionService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpButtonAndImage()
        addNoMovieElements()
        createParticles()
    }
    
    // MARK: - Public methods
    
    func setUpButtonAndImage() {
        exitButton.layer.cornerRadius = 0.02 * exitButton.bounds.size.width
        avatarImageView.layer.cornerRadius = 0.17 * exitButton.bounds.size.width
    }
    
    // MARK: - IBAction
    
    @IBAction func exitButtonTapped(_ sender: Any) {
        guard let session = try? ManageKeychain().getSessionID() else { return }
        deleteSessionService.deleteSession(session: session) { result in
            switch result {
            case .success:
                try? ManageKeychain().deleteSessionId()
                UserSettings.shareInstance.accountID = ""
                let appDelegate = UIApplication.shared.delegate as? AppDelegate
                appDelegate?.presentViewController()
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
    var ufoImage = UIImageView()
    
    func addNoMovieElements() {
        ufoImage = UIImageView(frame: CGRect(x: 64, y: 244, width: 248, height: 162))
        ufoImage.image = UIImage(named: "wheel_part")
        self.view.addSubview(ufoImage)
    }
    
    func createParticles() {
        let wheelParticleEmitter = CAEmitterLayer()
        wheelParticleEmitter.emitterPosition = CGPoint(x: ufoImage.frame.origin.x + 128,
                                                       y: ufoImage.frame.origin.y + 73)
        let wheel = makeWheelEmitterCell(color: UIColor.white)
        wheelParticleEmitter.emitterCells = [wheel]
        view.layer.addSublayer(wheelParticleEmitter)
        
        let pipeParticleEmitter = CAEmitterLayer()
        pipeParticleEmitter.emitterPosition = CGPoint(x: ufoImage.frame.origin.x + 233,
                                                      y: ufoImage.frame.origin.y + 68)
        let pipe = makePipeEmitterCell(color: UIColor.white)
        pipeParticleEmitter.emitterCells = [pipe]
        view.layer.insertSublayer(pipeParticleEmitter, below: ufoImage.layer)
        
        let cornCupParticleEmitter = CAEmitterLayer()
        cornCupParticleEmitter.emitterPosition = CGPoint(x: ufoImage.center.x,
                                                         y: ufoImage.center.y)
        let cornCup = makeOtherEmitterCell(image: "popcorn_cup")
        let waterCup = makeOtherEmitterCell(image: "water_cup")
        cornCupParticleEmitter.emitterCells = [cornCup, waterCup]
        view.layer.addSublayer(cornCupParticleEmitter)
        
        let popcornParticleEmitter = CAEmitterLayer()
        popcornParticleEmitter.emitterPosition = CGPoint(x: ufoImage.frame.origin.x + 45,
                                                         y: ufoImage.frame.origin.y + 70)
        //popcornParticleEmitter.emitterShape = .line
        let popcorn = makePopcornEmitterCell(image: "popcorn_image")
        popcornParticleEmitter.emitterCells = [popcorn]
        view.layer.addSublayer(popcornParticleEmitter)
    }

    func makeWheelEmitterCell(color: UIColor) -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.birthRate = 1
        cell.lifetime = 1.0
        cell.scale = 0.35
        //cell.lifetimeRange = 0
        cell.color = color.cgColor
        //cell.velocity = 1
        //cell.velocityRange = 100
        //cell.emissionLongitude = CGFloat.pi
        //cell.emissionRange = CGFloat.pi / 4
        cell.spin = 1
        //cell.spinRange = 3
        //cell.scaleRange = 1
        //cell.scaleSpeed = -0.05

        cell.contents = UIImage(named: "wheel_image")?.cgImage
        return cell
    }
    
    func makePipeEmitterCell(color: UIColor) -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.birthRate = 1
        cell.lifetime = 1.0
        cell.scale = 0.35
        //cell.lifetimeRange = 0
        cell.color = color.cgColor
        cell.velocity = 0.5
        //cell.velocityRange = 10
        //cell.emissionLongitude = CGFloat.pi
        //cell.emissionRange = CGFloat.pi / 4
        cell.spin = 0.3
        //cell.spinRange = 3
        //cell.scaleRange = 1
        //cell.scaleSpeed = -0.05

        cell.contents = UIImage(named: "pipe_image")?.cgImage
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
        cell.lifetime = 10.0
        cell.lifetimeRange = 0
        cell.scale = 0.35
        cell.velocity = 100
        cell.velocityRange = 50
        cell.emissionLongitude = CGFloat.pi
        cell.emissionRange = CGFloat.pi / 4
        //cell.spin = 1
        cell.contents = UIImage(named: image)?.cgImage
        return cell
    }
    
}
