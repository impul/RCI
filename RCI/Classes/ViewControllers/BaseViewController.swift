//
//  BaseNavigationController.swift
//  RCI
//
//  Created by Impulse on 07.02.17.
//  Copyright © 2017 Impulse. All rights reserved.
//

import UIKit

extension UIViewController {
    func setupNavigationBar () {
        let rigthButton = UIBarButtonItem(image: #imageLiteral(resourceName: "MainMenuButton"), style: .plain, target: self, action:#selector(UIViewController.rigthButtonAction))
        self.navigationItem.rightBarButtonItem = rigthButton
        let leftButton = UIBarButtonItem(image: #imageLiteral(resourceName: "BackButton"), style: .plain, target: self, action: #selector(UIViewController.backButtonAction))
        self.navigationItem.leftBarButtonItem = leftButton
    }

    func rigthButtonAction() {
        UIApplication.shared.keyWindow?.rootViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController")
    }
    
    func backButtonAction() {
        guard (self.navigationController?.viewControllers.count)! > 1 else {
             self.dismiss(animated: true, completion: nil)
            return
        }
        self.navigationController!.popViewController(animated: true)
    }
    
    func setTitle(titleString:String) {
        let title:UILabel = UILabel.init(frame:CGRect.init(x: 0.0, y: 0.0, width: 100.0, height: 40.0))
        title.text = titleString
        title.font = UIFont(name: "SFUIText-Semibold", size: 17)
        title.textColor = UIColor.defaultBlueColor
        self.navigationItem.titleView = title
        self.navigationController?.navigationBar.backgroundColor = UIColor.white 
    }
    
    func pushController(identifire:String) {
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: identifire) else {
            return
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
