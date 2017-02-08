//
//  ReportAccidentViewController.swift
//  RCI
//
//  Created by Impulse on 07.02.17.
//  Copyright © 2017 Impulse. All rights reserved.
//

import Foundation
import UIKit
import TextFieldEffects
import ImagePicker
import SVProgressHUD

class ReportAccidentViewController: BaseViewController , UICollectionViewDelegate, UICollectionViewDataSource, DeletePhotoProtocol, ImagePickerDelegate{

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var telephoneNumber: HoshiTextField!
    @IBOutlet weak var registrationNumber: HoshiTextField!
    @IBOutlet weak var nameTextField: HoshiTextField!
    @IBOutlet weak var iAgreeSwitch: UISwitch!
    
    var photosArray:Array<UIImage> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle(titleString: "Accident report")
    }
    
    @IBAction func reportAction(_ sender: Any) {
        if iAgreeSwitch.isOn {
            APIManager.sharedInstance.postAccident(name: nameTextField.text!, regNumber: registrationNumber.text! , phone: telephoneNumber.text!, photos: photosArray, completion: { (info, success) in
                if (success) {
                    SVProgressHUD.showSuccess(withStatus: info)
                    SVProgressHUD.dismiss(withDelay: 1, completion: {
                        self.backButtonAction()
                    })
                } else {
                    SVProgressHUD.showError(withStatus: info)
                }
            })
        } else {
            SVProgressHUD.showInfo(withStatus: "Accept conditions")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosArray.count+1;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let firstCell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "addPhotoCell", for: indexPath)
            return firstCell
        } else {
            let photoCell:PhotoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCell
            photoCell.imageView.image = photosArray[indexPath.row-1]
            photoCell.delegate = self
            photoCell.tag = indexPath.row - 1
            return photoCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let imagePickerController = ImagePickerController()
            imagePickerController.delegate = self
            
            present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    func deletePhoto(atIndex: Int) {
        self.photosArray .remove(at: atIndex)
        self.collectionView.reloadData()
    }
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {}
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {}
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        photosArray = photosArray + images
        collectionView.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
    
}
