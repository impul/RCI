//
//  PhotoCell.swift
//  RCI
//
//  Created by Impulse on 08.02.17.
//  Copyright © 2017 Impulse. All rights reserved.
//

import Foundation
import UIKit

protocol DeletePhotoProtocol {
    func deletePhoto(atIndex:Int)
}

class PhotoCell: UICollectionViewCell {
    
    var delegate:DeletePhotoProtocol?
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func deleteAction(_ sender: Any) {
        delegate?.deletePhoto(atIndex: tag)
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
   
}
