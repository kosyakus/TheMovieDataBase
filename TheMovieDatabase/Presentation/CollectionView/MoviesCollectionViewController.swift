//
//  MoviesCollectionViewController.swift
//  TheMovieDatabase
//
//  Created by Natali on 30.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import UIKit

enum CellType {
    case collectionCell, tableCell
}

class MoviesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var cellType: CellType = .collectionCell
    var moviesArray = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .clear
        setUpCell()
    }
    
    func setUpCell() {
        switch cellType {
        case .collectionCell:
            self.collectionView!.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil),
                                          forCellWithReuseIdentifier: "collectionCell")
        case .tableCell:
            self.collectionView!.register(UINib(nibName: "MovieTableCollectionViewCell", bundle: nil),
                                          forCellWithReuseIdentifier: "tableCell")
        }
    }
}

    // MARK: - UICollectionViewDataSource

extension MoviesCollectionViewController {
     
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch cellType {
        case .collectionCell:
            return 10
        case .tableCell:
            return 10
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cellIdentifier = ""
        if cellType == .tableCell {
            cellIdentifier = "tableCell"
        } else {
            cellIdentifier = "collectionCell"
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier,
                                                      for: indexPath) as! MovieCollectionViewCell
        
        return cell
    }
}

    // MARK: - UICollectionViewDelegate

extension MoviesCollectionViewController {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if cellType == .tableCell {
            return CGSize(width: 328, height: 98)
        } else {
            return CGSize(width: 152, height: 302)
        }
    }

}
