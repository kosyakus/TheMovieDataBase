//
//  FilmDetailViewController.swift
//  TheMovieDatabase
//
//  Created by Natali on 04.04.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import UIKit

class FilmDetailViewController: UIViewController {
    
    // MARK: - Constants
    
    private let plainHeartImage = #imageLiteral(resourceName: "favorite_plain_icon")
    private let filledHeartImage = #imageLiteral(resourceName: "favorite_filled_icon")
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieOriginalTitleLabel: UILabel!
    @IBOutlet weak var movieGenreLabel: UILabel!
    @IBOutlet weak var movieRuntimeLabel: UILabel!
    @IBOutlet weak var movieVoteLabel: UILabel!
    @IBOutlet weak var movieVoteCountLabel: UILabel!
    @IBOutlet weak var movieDescriptionTextView: UITextView!
    
    // MARK: - Public Properties
    
    var movie: Movie?
    let addMovieToFavoriteService: AddMovieToFavoriteService = ServiceLayer.shared.addMovieToFavoriteService
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
        showMovie()
    }
    
    // MARK: - Public methods
    
    /// Обработка фильма
    func showMovie() {
        guard let movie = movie else { return }
        if let poster = movie.poster {
            movieImageView.load(url: poster)
        }
        movieImageView.layer.cornerRadius = 2
        movieTitleLabel.text = movie.title
        movieOriginalTitleLabel.text = movie.originalTitle
        movieGenreLabel.text = ""
        movieRuntimeLabel.text = "0"
        movieVoteLabel.text = "\(movie.voteAverage ?? 0)"
        movieVoteCountLabel.text = "\(movie.voteCount ?? 0)"
        movieDescriptionTextView.text = movie.overview
        
    }

    /// Обработка нажатия на сердечко
    @objc func didTapFavoriteButton(sender: AnyObject) {
        print("didTapFavoriteButton")
        addAnimationToBarButton()
        addFavoriteMovie()
    }
    
    // MARK: - Private methods
    
    /// Добавление сердечка в NavBar
    private func setUpNavBar() {
        let favImageView = UIImageView(image: plainHeartImage)
        let button = UIButton(type: .custom)
        button.bounds = favImageView.bounds
        button.addSubview(favImageView)
        button.addTarget(self, action: #selector(didTapFavoriteButton), for: .touchUpInside)
        let favoriteButton = UIBarButtonItem(customView: button)

        navigationItem.rightBarButtonItem = favoriteButton
    }
    
    /// Добавление анимации на сердечко (rightBarButtonItem)
    private func addAnimationToBarButton() {
        navigationItem.rightBarButtonItem?.customView?.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.20),
                       initialSpringVelocity: CGFloat(6.0),
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations: {
                        self.navigationItem.rightBarButtonItem?.customView?.transform =
                            CGAffineTransform.identity },
                       completion: { _ in })
    }

    /// Обновление изображения сердечка
    private func updatePresentationStyle() {
        let fillImage = UIImageView(image: filledHeartImage)
        navigationItem.rightBarButtonItem?.customView?.addSubview(fillImage)
        navigationItem.rightBarButtonItem?.tintColor = UIColor.CustomColor.purpure
    }
    
    /// Метод для добавления фильмов в избранное. 
    private func addFavoriteMovie() {
        guard let session = try? ManageKeychain().getSessionID() else { return }
        addMovieToFavoriteService.addMovieToFavorite(session: session, movieId: movie?.id ?? 0) { _ in
            self.updatePresentationStyle()
        }
    }
}
