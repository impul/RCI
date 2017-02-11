//
//  ReportAccidentViewController.swift
//  RCI
//
//  Created by Impulse on 09.02.17.
//  Copyright © 2017 Impulse. All rights reserved.
//

import UIKit
import SVProgressHUD

struct ServiceType {
    static let personal = "personal"
    static let business = "business"
}

final class ServicesViewController : BaseCollection, InfoTableProtocol{
    
    var infoItemArray:[Service] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupWith(titles: ["BUSINESS", "PERSONAL"], delegate: self)
        setTitle(titleString: "Servicess")
    }
    
    func didPickInfo(info: String, atIndex: IndexPath) {
        let controller:InfoViewController = self.storyboard?.instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController
        controller.HTMLText = infoItemArray[atIndex.row].description
        controller.infoTitle = info
        controller.serviceTitle = info
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func getInfo(typeService: String, title:String) {
        APIManager.sharedInstance.getServices(withType: typeService) { [unowned self] (result, success) in
            SVProgressHUD.dismiss()
            if success {
                self.infoItemArray = result as! [Service]
                let controller:InfoTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "InfoTableViewController") as! InfoTableViewController
                controller.setupController(info: self.generateNamesArray() , infoDelegate: self, title: title)
                self.navigationController?.pushViewController(controller, animated: true)
            } else {
                SVProgressHUD.showError(withStatus: result as? String)
            }
        }
    }
    
    func generateNamesArray() -> [String] {
        var namesArray:[String] = []
        for service in infoItemArray  {
            namesArray.append(service.title)
        }
        return namesArray
    }
    
//MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if SVProgressHUD.isVisible() {
            return
        }
        SVProgressHUD.show()
        switch indexPath.row {
        case 0: getInfo(typeService: ServiceType.business, title: "Business")
            break
        case 1: getInfo(typeService: ServiceType.personal, title: "Personal")
            break
            
        default:
            break
        }
    }
    
}
