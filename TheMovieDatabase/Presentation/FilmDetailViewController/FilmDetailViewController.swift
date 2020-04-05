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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
        showMovie()
    }
    
    // MARK: - Public methods
    
    func setUpNavBar() {
        let favoriteButton = UIBarButtonItem(image: plainHeartImage,
                                             style: .plain,
                                             target: self,
                                             action: #selector(didTapFavoriteButton))
        
        navigationItem.rightBarButtonItem = favoriteButton
    }
    
    func showMovie() {
        guard let movie = movie else { return }
        if let poster = movie.poster {
            movieImageView.load(url: poster)
        }
        movieTitleLabel.text = movie.title
        movieOriginalTitleLabel.text = movie.originalTitle
        movieGenreLabel.text = ""
        movieRuntimeLabel.text = "0"
        movieVoteLabel.text = "\(movie.voteAverage ?? 0)"
        movieVoteCountLabel.text = "\(movie.voteCount ?? 0)"
        movieDescriptionTextView.text = movie.overview
        
    }

    @objc func didTapFavoriteButton(sender: AnyObject) {
        print("didTapFavoriteButton")
        updatePresentationStyle()
    }
    
    /// Обновление изображения сердечка
    private func updatePresentationStyle() {
        navigationItem.rightBarButtonItem?.image = filledHeartImage
    }
}
