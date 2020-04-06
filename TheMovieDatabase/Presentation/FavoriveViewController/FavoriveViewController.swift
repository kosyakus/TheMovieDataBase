//
//  FavoriveViewController.swift
//  TheMovieDatabase
//
//  Created by Natali on 07.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import TheMovieDatabaseAPI
import UIKit

protocol ParentToChildProtocol: class {
    
    var moviesArray: [Movie] { get set }
    
    func navBarButtonClickedByUser()
    func reloadData()
}

final class FavoriveViewController: UIViewController {
    
    // MARK: - Constants
    
    private let listImage = #imageLiteral(resourceName: "list_icon")
    private let searchImage = #imageLiteral(resourceName: "search_icon")
    private let collectionImage = #imageLiteral(resourceName: "widgets_icon")
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var noMovieView: UIImageView!
    @IBOutlet weak var noMovieLabel: UILabel!
    @IBOutlet weak var findMoviesButton: UIButton!
    
    // MARK: - Public Properties
    
    let favoriteService: FavoriteServices = ServiceLayer.shared.favoriteService
    let cellVC = MoviesCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
    var cellType: CellType = .collectionCell
    weak var delegate: ParentToChildProtocol?
    var buttonImage: UIImage {
        switch cellType {
        case .collectionCell:
            return listImage
        case .tableCell:
            return collectionImage
        }
    }
    
    // MARK: - FavoriveViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
        loadFavoriteMovies()
        
        self.addCollection(self.cellVC)
        cellVC.view.isHidden = true
        noMovieView.isHidden = true
    }
    
    // MARK: - Public methods
    
    func setUpNavBar() {
        let listButton = UIBarButtonItem(image: buttonImage,
                                         style: .plain,
                                         target: self,
                                         action: #selector(didTapEditButton))
        let searchButton = UIBarButtonItem(image: searchImage,
                                           style: .plain,
                                           target: self,
                                           action: #selector(didTapSearchButton))
        
        navigationItem.rightBarButtonItems = [listButton, searchButton]
    }
    
    @objc func didTapEditButton(sender: AnyObject) {
        print("didTapEditButton")
        delegate?.navBarButtonClickedByUser()
        switch cellType {
        case .collectionCell:
            cellType = .tableCell
        case .tableCell:
            cellType = .collectionCell
        }
        updatePresentationStyle()
    }
    
    @objc func didTapSearchButton(sender: AnyObject) {
        print("didTapSearchButton")
    }
    
    // MARK: - Private Methods
    
    /// Добавление childView
    private func addCollection(_ viewController: UIViewController) {
        self.addContainerView(viewController)
        self.delegate = cellVC
    }
    
    /// Метод для загрузки любимых фильмов.  Получает фильмы, добавляет их в moviesArray и обновляет коллекцию
    private func loadFavoriteMovies() {
        favoriteService.fetchFavoriteMovies { result in
            //print(result)
            switch result {
            case .success(let movies):
                if !movies.isEmpty {
                    self.proceedFindedMovieScreen()
                    self.delegate?.moviesArray = movies
                    self.delegate?.reloadData()
                } else {
                    self.proceedNoMovieScreen()
                }
            case .failure(let error):
                print(error)
            
            }
        }
    }
    
    /// Обновление изображения списка/таблицы
    private func updatePresentationStyle() {
        navigationItem.rightBarButtonItems?[0].image = buttonImage
    }
    
    /// Обработка экрана при отсутствии фильмов в избранном
    func proceedNoMovieScreen() {
        cellVC.view.isHidden = true
        self.noMovieView.isHidden = false
        self.noMovieLabel.isHidden = false
        self.findMoviesButton.isHidden = false
        createParticles()
    }
    
    /// Обработка экрана при получении фильмов в избранном
    func proceedFindedMovieScreen() {
        cellVC.view.isHidden = false
        self.noMovieView.isHidden = true
        self.noMovieLabel.isHidden = true
        self.findMoviesButton.isHidden = true
    }
    
    /// Создание анимации при отсутствии фильмов в избранном
    func createParticles() {
        let wheelParticleEmitter = CAEmitterLayer()
        wheelParticleEmitter.emitterPosition = CGPoint(x: noMovieView.frame.origin.x + 128,
                                                       y: noMovieView.frame.origin.y + 73)
        let wheel = makeWheelEmitterCell(color: UIColor.white)
        wheelParticleEmitter.emitterCells = [wheel]
        view.layer.addSublayer(wheelParticleEmitter)
        
        let pipeParticleEmitter = CAEmitterLayer()
        pipeParticleEmitter.emitterPosition = CGPoint(x: noMovieView.frame.origin.x + 233,
                                                      y: noMovieView.frame.origin.y + 68)
        let pipe = makePipeEmitterCell(color: UIColor.white)
        pipeParticleEmitter.emitterCells = [pipe]
        view.layer.insertSublayer(pipeParticleEmitter, below: noMovieView.layer)
        
        let cornCupParticleEmitter = CAEmitterLayer()
        cornCupParticleEmitter.emitterPosition = CGPoint(x: noMovieView.center.x,
                                                         y: noMovieView.center.y)
        let cornCup = makeOtherEmitterCell(image: "popcorn_cup")
        let waterCup = makeOtherEmitterCell(image: "water_cup")
        cornCupParticleEmitter.emitterCells = [cornCup, waterCup]
        view.layer.addSublayer(cornCupParticleEmitter)
        
        let popcornParticleEmitter = CAEmitterLayer()
        popcornParticleEmitter.emitterPosition = CGPoint(x: noMovieView.frame.origin.x + 45,
                                                         y: noMovieView.frame.origin.y + 70)
        popcornParticleEmitter.emitterShape = .circle
        //popcornParticleEmitter.emitterSize = CGSize(width: 50, height: 1)
        popcornParticleEmitter.emitterMode = .outline
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
        cell.emissionLongitude = 1
        cell.emissionRange = 100
        cell.contents = UIImage(named: image)?.cgImage
        return cell
    }
}
