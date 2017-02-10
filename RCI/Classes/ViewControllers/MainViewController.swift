//
//  MainViewController.swift
//  RCI
//
//  Created by Impulse on 07.02.17.
//  Copyright © 2017 Impulse. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let titleArray:Array<String> = ["ROYAL ASSIST", "ROYAL PAYMANT","SERVICE","WHAT TO DO IF","ABOUT","QUESTIONNARIES"]
    
     override func viewDidLoad() {
        self.navigationController?.navigationBar.shadowImage = UIImage.init()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.init(), for: UIBarMetrics.default)
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MainControllerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainControllerCell", for: indexPath) as! MainControllerCell
        cell.imageView.image = UIImage.init(named: titleArray[indexPath.row])
        cell.titleLable.text = titleArray[indexPath.row]
        return cell;
    }
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if ((indexPath.row+1) % 3 == 0) {
            return CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height*0.292)
        } else {
            return CGSize(width: self.view.frame.size.width/2-6, height: self.view.frame.size.height*0.292)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            customPushController(name: "RoyalAssistViewController",atIndex: indexPath.row)
            break
        case 1:
            break
        case 2:
            customPushController(name: "ServicesViewController",atIndex: indexPath.row)
            break
        default:
            break
        }
    }
    
    func customPushController(name:String, atIndex:Int) {
        let navigaton:UINavigationController = UINavigationController()
        navigaton.navigationItem.title = titleArray[atIndex]
        let controller:UIViewController = (self.storyboard?.instantiateViewController(withIdentifier: name))!
        navigaton.pushViewController(controller, animated: true)
        self.present(navigaton, animated: true, completion: nil)
        
    }
    
}
