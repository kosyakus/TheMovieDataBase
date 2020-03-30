//
//  MoviesCollectionViewController.swift
//  TheMovieDatabase
//
//  Created by Natali on 29.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import UIKit



class MoviesCollectionViewController2: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var cellType: CellType = .collectionCell
    var moviesArray = [Movie]()
    
    let cellId: String = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = UIColor.CustomColor.light
        collectionView.dataSource = self
        collectionView.delegate = self
        
        setUpCell()
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func setUpCell() {
        switch cellType {
        case .collectionCell:
            //self.collectionView!.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil),
                                          //forCellWithReuseIdentifier: "collectionCell")
            self.collectionView!.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        case .tableCell:
            self.collectionView!.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil),
                                          forCellWithReuseIdentifier: "tableCell")
        }
        
        let contentWidth = Double(collectionView!.numberOfSections) * 70
        let contentHeight = Double(collectionView!.numberOfItems(inSection: 0)) * 70
        self.collectionView.contentSize = CGSize(width: contentWidth, height: contentHeight)
    }
}

    // MARK: - UICollectionViewDataSource

extension MoviesCollectionViewController2 {
    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch cellType {
        case .collectionCell:
            return 2
        case .tableCell:
            return 1
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell",
//                                                      for: indexPath) as! MovieCollectionViewCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
//        switch cellType {
//        case .collectionCell:
//            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell",
//                                                      for: indexPath) as! MovieCollectionViewCell
//        case .tableCell:
//            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tableCell",
//                                                      for: indexPath) as! MovieCollectionViewCell
//        }
        cell.backgroundColor = .red
        return cell
    }
}

    // MARK: - UICollectionViewDelegate

extension MoviesCollectionViewController2 {
    
    /*
         // Uncomment this method to specify if the specified item should be highlighted during tracking
         override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
         return true
         }
         */
        
        /*
         // Uncomment this method to specify if the specified item should be selected
         override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
         return true
         }
         */
        
        /*
         // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
         override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
         return false
         }
         
         override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
         return false
         }
         
         override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
         
         }
         */
        //
    //}
}

//extension MoviesCollectionViewController {
//    //1
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//        //2
//        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
//        let availableWidth = view.frame.width - paddingSpace
//        let widthPerItem = availableWidth / itemsPerRow
//
//        return CGSize(width: widthPerItem, height: widthPerItem)
//    }
//}
