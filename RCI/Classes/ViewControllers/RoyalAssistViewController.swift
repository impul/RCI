//
//  RoyalAssistViewController.swift
//  RCI
//
//  Created by Impulse on 07.02.17.
//  Copyright © 2017 Impulse. All rights reserved.
//

import Foundation
import UIKit

class RoyalAssistViewController: BaseViewController , UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    let titleArray:Array<String> = ["REPORT AN ACCIDENT", "MAKE A CALL", "ABOUT ROYAL ASSIST"]
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MainControllerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainControllerCell", for: indexPath) as! MainControllerCell
        cell.imageView.image = UIImage.init(named: titleArray[indexPath.row])
        cell.titleLable.text = titleArray[indexPath.row]
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height*0.292)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0: //presentController(nameController:MainViewController())
            break
        case 1: self.makeACall()
            break
        case 2: //presentController(nameController:"AboutRoyalViewController")
            break
        default:
            break
        }
    }
    
    func makeACall(){
        if let phoneCallURL:URL = URL(string: "tel://\(supportPhoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options:[:], completionHandler: nil)
            }
        }
    }
    
    
}
