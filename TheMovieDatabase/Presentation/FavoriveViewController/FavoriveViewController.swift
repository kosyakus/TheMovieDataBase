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
        //loadFavoriteMovies()
        
        self.addCollection(self.cellVC)
        cellVC.view.isHidden = true
        noMovieView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadFavoriteMovies()
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
        guard let session = try? ManageKeychain().getSessionID() else { return }
        favoriteService.fetchFavoriteMovies(session: session) { result in
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
    private func proceedNoMovieScreen() {
        cellVC.view.isHidden = true
        self.noMovieView.isHidden = false
        self.noMovieLabel.isHidden = false
        self.findMoviesButton.isHidden = false
        createParticles()
    }
    
    /// Обработка экрана при получении фильмов в избранном
    private func proceedFindedMovieScreen() {
        let layers = view.layer.sublayers
        for layer in layers! {
            if layer.isKind(of: CAEmitterLayer.self) {
                layer.removeFromSuperlayer()
            }
        }
        cellVC.view.isHidden = false
        self.noMovieView.isHidden = true
        self.noMovieLabel.isHidden = true
        self.findMoviesButton.isHidden = true
    }
    
    /// Создание анимации при отсутствии фильмов в избранном
    private func createParticles() {
        let animation = AnimationController()
        let wheelParticleEmitter = CAEmitterLayer()
        wheelParticleEmitter.emitterPosition = CGPoint(x: noMovieView.center.x,
                                                       y: noMovieView.center.y)
        let wheel = animation.makeWheelEmitterCell(color: UIColor.white)
        wheelParticleEmitter.emitterCells = [wheel]
        view.layer.addSublayer(wheelParticleEmitter)
        
        let pipeParticleEmitter = CAEmitterLayer()
        pipeParticleEmitter.emitterPosition = CGPoint(x: noMovieView.center.x,
                                                      y: noMovieView.center.y)
        let pipe = animation.makePipeEmitterCell(color: UIColor.white)
        pipeParticleEmitter.emitterCells = [pipe]
        view.layer.insertSublayer(pipeParticleEmitter, below: noMovieView.layer)
        
        let cornCupParticleEmitter = CAEmitterLayer()
        cornCupParticleEmitter.emitterPosition = CGPoint(x: noMovieView.center.x,
                                                         y: noMovieView.center.y)
        let cornCup = animation.makeOtherEmitterCell(image: "popcorn_cup")
        let waterCup = animation.makeOtherEmitterCell(image: "water_cup")
        cornCupParticleEmitter.emitterCells = [cornCup, waterCup]
        view.layer.addSublayer(cornCupParticleEmitter)
        
        let popcornParticleEmitter = CAEmitterLayer()
        popcornParticleEmitter.emitterPosition = CGPoint(x: noMovieView.frame.origin.x + 45,
                                                         y: noMovieView.frame.origin.y + 70)
        popcornParticleEmitter.emitterShape = .circle
        popcornParticleEmitter.emitterMode = .outline
        let popcorn = animation.makePopcornEmitterCell(image: "popcorn_image")
        popcornParticleEmitter.emitterCells = [popcorn]
        view.layer.addSublayer(popcornParticleEmitter)
    }
}
