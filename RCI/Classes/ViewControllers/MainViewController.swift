//
//  MainViewController.swift
//  RCI
//
//  Created by Impulse on 07.02.17.
//  Copyright © 2017 Impulse. All rights reserved.
//

import UIKit
import SVProgressHUD

class MainViewController: UIViewController {
    
    let titleArray = ["ROYAL ASSIST", "ROYAL PAYMANT","SERVICE","WHAT TO DO IF","ABOUT","QUESTIONNARIES"]
    var infoItemArray:[AccidentInstructions] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController? .setNavigationBarHidden(true, animated: false)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
    }
    
}

extension MainViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let controller: UIViewController = (storyboard?.instantiateViewController(withIdentifier: "BaseCollection"))!
            object_setClass(controller, RoyalAssistViewController.self)
            customPushController(controller:controller)
            break
        case 2:
            let controller: UIViewController = (storyboard?.instantiateViewController(withIdentifier: "BaseCollection"))!
            object_setClass(controller, ServicesViewController.self)
            customPushController(controller:controller)
            break
        case 3:
            whatToDoIfAction()
            break
        case 4:
            let controller: UIViewController = (storyboard?.instantiateViewController(withIdentifier: "BaseCollection"))!
            object_setClass(controller, AboutController.self)
            customPushController(controller:controller)
            break
        default:
            break
        }
    }

//MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (indexPath.row+1) % 3 == 0 {
            return CGSize(width: view.frame.size.width, height: view.frame.size.height*0.292)
        } else {
            return CGSize(width: view.frame.size.width/2.0-6.0, height: view.frame.size.height*0.292)
        }
    }
}

extension MainViewController: InfoTableProtocol {
    
    func whatToDoIfAction() {
        if SVProgressHUD.isVisible() {
            return
        }
        SVProgressHUD.show()
        APIManager.sharedInstance.getAccidentInstructions { [unowned self] (result, success) in
            SVProgressHUD.dismiss()
            if success {
                self.infoItemArray = result as! [AccidentInstructions]
                let controller:InfoTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "InfoTableViewController") as! InfoTableViewController
                controller.setupController(info: self.generateNamesArray() , infoDelegate: self, title: "What to do if")
                self.customPushController(controller: controller)
            } else {
                SVProgressHUD.showError(withStatus: result as? String)
            }
        }
    }
    
    func didPickInfo(info: String, atIndex: IndexPath) {
        let controller:WhatToDoIfController = storyboard?.instantiateViewController(withIdentifier: "WhatToDoIfController") as! WhatToDoIfController
        controller.instruction = infoItemArray[atIndex.row]
        controller.infoTitle = info
        customPushController(controller: controller)
    }
    
    func generateNamesArray() -> [String] {
        var namesArray:[String] = []
        for service in infoItemArray  {
            namesArray.append(service.title)
        }
        return namesArray
    }
}
