//
//  MovieCollectionViewCell.swift
//  TheMovieDatabase
//
//  Created by Natali on 29.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var originalMovieNameLabel: UILabel!
    @IBOutlet weak var genreLable: UILabel!
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
