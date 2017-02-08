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
            return CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height*0.292)
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
        let textStr = "The Road Assistance Services Royal Assist is available to you 24 hours each day and 365 each year, and can arrange the transportation of your immobilised vehicle using state-of-art trailer and crane lorries, to the service centre of your preference or your place of residence free of charge. It also offers minor repair and mechanical and electrical fault repair services, water, fuel or oil shortage services, tyre change services, unlocking or restarting services, as well as noise checks in the engine, the gearbox or tyres.Furthermore, this collaboration creates a breakthrough in terms of speedy service in the case that you are involved in a road traffic accident, as qualified staff will meet you at the scene and assist in any way possible.In the case of accident or need for Road Services, just call 77.77.77.73 for immediate assistance."
        let controller:InfoViewController = (self.storyboard?.instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController)
        controller.HTMLText = textStr
        controller.infoTitle = "About royal assist"
        self.navigationController?.pushViewController(controller, animated: true)

//        APIManager.sharedInstance.getAboutAccident { (info, result) in
//            
//        }
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
