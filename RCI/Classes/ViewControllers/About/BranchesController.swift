//
//  BranchesController.swift
//  RCI
//
//  Created by Impulse on 11.02.17.
//  Copyright © 2017 Impulse. All rights reserved.
//

import UIKit
import GoogleMaps
import SVProgressHUD

class BranchesViewController : UIViewController {
    
    @IBOutlet weak var sizeArrowButton: UIButton!
    @IBOutlet weak var viewForMap: UIView!
    @IBOutlet weak var branchTitle: UILabel!
    @IBOutlet weak var branchDescription: UILabel!
    @IBOutlet weak var buttomViewHeight: NSLayoutConstraint!
    
    var map: GMSMapView?
    var currentBranch: BranchesPoint?
    var pointArray: [BranchesPoint] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setTitle(titleString: "Branches")
        buttomViewHeight.constant = 0
        view.layoutIfNeeded()
        setupMap()
    }
    
    func setupMap() {
        map = GMSMapView(frame: viewForMap.bounds)
        map?.settings.myLocationButton = true
        map?.isMyLocationEnabled = true
        map?.delegate = self
        viewForMap.addSubview(map!)
        weak var this = self
        APIManager.sharedInstance.getBranches { (info, result) in
            guard result else {
                SVProgressHUD.showInfo(withStatus: info as! String )
                return
            }
            this?.pointArray = info as! [BranchesPoint]
            for point in (this?.pointArray)! {
                let marker:GMSMarker = GMSMarker(position: CLLocationCoordinate2DMake(point.latitude, point.longitude))
                marker.icon = #imageLiteral(resourceName: "icPinActive")
                marker.appearAnimation = kGMSMarkerAnimationPop
                marker.map = this?.map
                marker.userData = point
            }
            self.map?.animate(toLocation: CLLocationCoordinate2DMake(self.pointArray[0].latitude, self.pointArray[0].longitude))
        }
    }
    
//MARK: - Actions
    
    @IBAction func findWayAction(_ sender: UIButton) {
        guard let myLocation = map?.myLocation?.coordinate else {
            SVProgressHUD.showError(withStatus: "Cannot find location!")
            return
        }
        let origin = "\(myLocation.latitude),\(myLocation.longitude)"
        let destination = "\(currentBranch?.latitude),\(currentBranch?.longitude)"
        

    }
    
    @IBAction func changeSizeAction(_ sender: UIButton) {
        if sender.image(for: .normal) == #imageLiteral(resourceName: "icArrowDown") {
            sender.setImage(#imageLiteral(resourceName: "icArrowUp"), for: .normal)
            UIView.animate(withDuration: 0.5) {
                self.buttomViewHeight.constant = 105.0
                self.view.layoutIfNeeded()
            }
        } else {
            sender.setImage(#imageLiteral(resourceName: "icArrowDown"), for: .normal)
            UIView.animate(withDuration: 0.5) {
                self.buttomViewHeight.constant = 205.0
                self.view.layoutIfNeeded()
            }
        }
    }
}

extension BranchesViewController : GMSMapViewDelegate {
    
//MARK: - GMSMapViewDelegate
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        let point = marker.userData as! BranchesPoint
        branchTitle.text = point.title
        branchDescription.text = point.getFormatedDescription()
        sizeArrowButton.setImage(#imageLiteral(resourceName: "icArrowUp"), for: .normal)
        currentBranch = point
        UIView.animate(withDuration: 0.5) {
            self.buttomViewHeight.constant = 105.0
            self.view.layoutIfNeeded()
        }
        return true
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        guard let myLocation = map?.myLocation?.coordinate else {
            SVProgressHUD.showError(withStatus: "Cannot find location!")
            return false
        }
        let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(myLocation.latitude , myLocation.longitude)
        map?.animate(toLocation: coordinate)

        return true
    }

    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        guard self.buttomViewHeight.constant != 0 else {
            return
        }
        sizeArrowButton.setImage(#imageLiteral(resourceName: "icArrowUp"), for: .normal)
        UIView.animate(withDuration: 0.5) {
            self.buttomViewHeight.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
}

