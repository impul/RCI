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

final class RoyalAssistViewController: BaseCollection  {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWith(titles: ["REPORT AN ACCIDENT", "MAKE A CALL", "ABOUT ROYAL ASSIST"], delegate: self)
        setupNavigationBar()
        setTitle(titleString: "Royal assist")
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
