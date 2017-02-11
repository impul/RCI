//
//  RoyalAssistViewController.swift
//  RCI
//
//  Created by Impulse on 07.02.17.
//  Copyright © 2017 Impulse. All rights reserved.
//

import UIKit
import SVProgressHUD

let supportPhoneNumber = "77777773"

class RoyalAssistViewController: UIViewController  {
    
    let titleArray = ["REPORT AN ACCIDENT", "MAKE A CALL", "ABOUT ROYAL ASSIST"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setTitle(titleString: "Royal asset")
    }
    
    func showInfo() {
        if SVProgressHUD.isVisible() {
            return
        }
        SVProgressHUD.show()
        APIManager.sharedInstance.getAboutAccident { (result, succes) in
            SVProgressHUD.dismiss()
            guard succes else {
                SVProgressHUD.showError(withStatus: result)
                return
            }
            let controller:InfoViewController = (self.storyboard?.instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController)
            controller.HTMLText = result
            controller.infoTitle = "About royal assist"
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func makeACall(){
        guard let phoneCallURL:URL = URL(string: "tel://\(supportPhoneNumber)") else { return }
        let application:UIApplication = UIApplication.shared
        guard (application.canOpenURL(phoneCallURL)) else  { return }
        application.open(phoneCallURL, options:[:], completionHandler: nil)
    }
}

extension RoyalAssistViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

//MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MainControllerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainControllerCell", for: indexPath) as! MainControllerCell
        cell.imageView.image = UIImage(named: titleArray[indexPath.row])
        cell.titleLable.text = titleArray[indexPath.row]
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleArray.count
    }
    
//MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width, height:(collectionView.frame.size.height-83.0)/3.0)
    }

//MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0: customPushController(name: "ReportAccidentViewController")
            break
        case 1: makeACall()
            break
        case 2: showInfo()
            break
        default:
            break
        }
    }
}
