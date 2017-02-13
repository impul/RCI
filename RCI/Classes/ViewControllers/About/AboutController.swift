//
//  AboutController.swift
//  RCI
//
//  Created by Impulse on 11.02.17.
//  Copyright © 2017 Impulse. All rights reserved.
//

import UIKit
import SVProgressHUD

final class AboutController : BaseCollection{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupWith(titles: ["ABOUT US", "BRANCHES", "E-NSURED"], delegate: self)
        setTitle(titleString: "About")
    }
    
    func didPickInfo(info: String, atIndex: IndexPath) {
//        let controller:InfoViewController = self.storyboard?.instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController
//        controller.HTMLText = infoItemArray[atIndex.row].description
//        controller.infoTitle = info
//        controller.serviceTitle = info
//        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func showAboutUs() {
        if SVProgressHUD.isVisible() {
            return
        }
        SVProgressHUD.show()
        APIManager.sharedInstance.getAboutUs { (result, succes) in
            SVProgressHUD.dismiss()
            guard succes else {
                SVProgressHUD.showError(withStatus: result)
                return
            }
            let controller:InfoViewController = (self.storyboard?.instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController)
            controller.HTMLText = result
            controller.infoTitle = "About us"
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }

    //MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0: showAboutUs()
            break
        case 1: customPushController(name:"BranchesViewController")
            break
            
        default:
            break
        }
    }
    
}
