//
//  RoyalAssistViewController.swift
//  RCI
//
//  Created by Impulse on 07.02.17.
//  Copyright © 2017 Impulse. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

class RoyalAssistViewController: BaseViewController , UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    let titleArray:Array<String> = ["REPORT AN ACCIDENT", "MAKE A CALL", "ABOUT ROYAL ASSIST"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle(titleString: "Royal asset")
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: self.view.frame.size.width, height:(collectionView.frame.size.height-83)/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0: presentController(nameController:ReportAccidentViewController())
            break
        case 1: makeACall()
            break
        case 2: showInfo()
            break
        default:
            break
        }
    }
    
    func showInfo() {
        APIManager.sharedInstance.getAboutAccident { (result, succes) in
            if succes {
                let controller:InfoViewController = (self.storyboard?.instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController)
                controller.HTMLText = result
                controller.infoTitle = "About royal assist"
                
                self.navigationController?.pushViewController(controller, animated: true)
            } else {
                SVProgressHUD.showError(withStatus: result)
            }
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
