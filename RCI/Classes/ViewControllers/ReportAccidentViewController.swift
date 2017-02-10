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

class ReportAccidentViewController: UIViewController , DeletePhotoProtocol, ImagePickerDelegate{

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var telephoneNumber: HoshiTextField!
    @IBOutlet weak var registrationNumber: HoshiTextField!
    @IBOutlet weak var nameTextField: HoshiTextField!
    @IBOutlet weak var iAgreeSwitch: UISwitch!
    
    var photosArray:[UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setTitle(titleString: "Accident report")
    }
    
    @IBAction func reportAction(_ sender: Any) {
        if iAgreeSwitch.isOn {
            APIManager.sharedInstance.postAccident(name: nameTextField.text!, regNumber: registrationNumber.text! , phone: telephoneNumber.text!, photos: generateDataPhotoArray(), completion: { [weak self] (info, success) in
                if (success) {
                    SVProgressHUD.showSuccess(withStatus: info)
                    SVProgressHUD.dismiss(withDelay: 1, completion: {
                        self?.backButtonAction()
                    })
                } else {
                    SVProgressHUD.showError(withStatus: info)
                }
            })
        } else {
            SVProgressHUD.showInfo(withStatus: "Accept conditions")
        }
    }
    
    func generateDataPhotoArray() -> [Data] {
        var dataArray:[Data] = []
        for image in photosArray {
            dataArray.append(UIImageJPEGRepresentation(image, 1)!)
        }
        return dataArray
        
    }
    
//MARK: - DeletePhotoProtocol
    
    func deletePhoto(atIndex: Int) {
        photosArray.remove(at: atIndex)
        collectionView.reloadData()
    }
 
//MARK: - ImagePicker
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {}
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {}
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        photosArray = photosArray + images
        collectionView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
}

extension ReportAccidentViewController :  UICollectionViewDelegate, UICollectionViewDataSource {

//MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosArray.count+1
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
    
//MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let imagePickerController = ImagePickerController()
            imagePickerController.delegate = self
            present(imagePickerController, animated: true, completion: nil)
        }
    }

}
