//
//  BaseCollection.swift
//  RCI
//
//  Created by Impulse on 11.02.17.
//  Copyright © 2017 Impulse. All rights reserved.
//

import UIKit

class BaseCollection : UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var titleArray:[String] = []
    var type: Int?
    
    func setupWith(titles:[String], delegate:UICollectionViewDelegate ) {
        collectionView.dataSource = self
        collectionView.delegate = delegate
        titleArray = titles
        collectionView.reloadData()
    }
}

extension BaseCollection: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MainControllerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainControllerCell", for: indexPath) as! MainControllerCell
        cell.imageView.image = UIImage(named: titleArray[indexPath.row])
        cell.titleLable.text = titleArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width,
                      height: (collectionView.frame.size.height-62.0 - CGFloat((titleArray.count-1)*10) )/CGFloat(titleArray.count))
    }
}
