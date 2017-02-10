//
//  ReportAccidentViewController.swift
//  RCI
//
//  Created by Impulse on 09.02.17.
//  Copyright © 2017 Impulse. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

struct ServiceType {
    static let personal = "personal"
    static let business = "business"
}

class ServicesViewController : BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, InfoTableProtocol{
    
    var infoItemArray:Array<Service> = []
    let titleArray:Array<String> = ["BUSINESS", "PERSONAL"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle(titleString: "Servicess")
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
        return CGSize(width: self.view.frame.size.width, height:(collectionView.frame.size.height-73)/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0: getInfo(typeService: ServiceType.business, title: "Business")
            break
        case 1: getInfo(typeService: ServiceType.personal, title: "Personal")
            break

        default:
            break
        }
    }
    
    func didPickInfo(info: String, atIndex: IndexPath) {
        let controller:InfoViewController = self.storyboard?.instantiateViewController(withIdentifier: "ServiceInfoViewController") as! InfoViewController
        controller.HTMLText = infoItemArray[atIndex.row].description
        controller.infoTitle = info
        controller.serviceTitle = info
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func getInfo(typeService: String, title:String) {
        APIManager.sharedInstance.getServices(withType: typeService) { (result, success) in
            if success {
                self.infoItemArray = result as! Array<Service>
                let controller:InfoTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "InfoTableViewController") as! InfoTableViewController
                controller.setupController(info: self.generateNamesArray() , infoDelegate: self, title: title)
                self.navigationController?.pushViewController(controller, animated: true)
            } else {
                SVProgressHUD.showError(withStatus: result as? String)
            }
        }
    }
    
    func generateNamesArray() -> Array<String> {
        var namesArray:Array<String>? = Array.init()
        for service:Service in infoItemArray  {
            namesArray?.append(service.title)
        }
        return namesArray!
    }
    

    
    
}
