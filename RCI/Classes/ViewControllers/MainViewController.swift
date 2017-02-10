//
//  MainViewController.swift
//  RCI
//
//  Created by Impulse on 07.02.17.
//  Copyright © 2017 Impulse. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let titleArray = ["ROYAL ASSIST", "ROYAL PAYMANT","SERVICE","WHAT TO DO IF","ABOUT","QUESTIONNARIES"]
    
    override func viewDidLoad() {
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
    }
    
    func customPushController(name:String, atIndex:Int) {
        let navigaton: UINavigationController = UINavigationController()
        let controller: UIViewController = (storyboard?.instantiateViewController(withIdentifier: name))!
        navigaton.pushViewController(controller, animated: true)
        present(navigaton, animated: true)
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
            customPushController(name: "RoyalAssistViewController",atIndex: indexPath.row)
            break
        case 2:
            customPushController(name: "ServicesViewController",atIndex: indexPath.row)
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
