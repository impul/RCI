//
//  BaseNavigationController.swift
//  RCI
//
//  Created by Impulse on 07.02.17.
//  Copyright © 2017 Impulse. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController : UIViewController {
    override func viewDidLoad() {
       let rigthButton = UIBarButtonItem(image: UIImage.init(named: "MainMenuButton"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(BaseViewController.rigthButtonAction))
        self.navigationItem.rightBarButtonItem = rigthButton
        let leftButton = UIBarButtonItem(image: UIImage.init(named: "BackButton"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(BaseViewController.backButtonAction))
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    func rigthButtonAction() {
        UIApplication.shared.keyWindow?.rootViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController")
    }
    
    func backButtonAction() {
        if ((self.navigationController?.viewControllers.count)! > 1) {
            self.navigationController!.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func setTitle(titleString:String) {
        let title:UILabel = UILabel.init(frame:CGRect.init(x: 0, y: 0, width: 100, height: 40))
        title.text = titleString
        title.font = UIFont.init(name: "SFUIText-Semibold", size: 17)
        title.textColor = UIColor.defaultBlueColor()
        self.navigationItem.titleView = title
        self.navigationController?.navigationBar.backgroundColor = UIColor.white 
    }
    
    func presentController<T>(nameController:T) {
        let controllerString = String(describing: type(of:nameController))
        let controller = (self.storyboard?.instantiateViewController(withIdentifier: controllerString))
        self.navigationController?.pushViewController(controller!, animated: true)
    }
}
