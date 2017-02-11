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
    
    @IBOutlet weak var viewForMap: UIView!
    var map:GMSMapView?
    var pointArray:[BranchesPoint] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setTitle(titleString: "Branches")
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
                marker.map = this?.map
            }
        }
    }
}

extension BranchesViewController : GMSMapViewDelegate {
    
//MARK: - GMSMapViewDelegate
    
    func mapView(_ mapView: GMSMapView, didDrag marker: GMSMarker) {
        
    }
    
    func mapView(_ mapView: GMSMapView, didBeginDragging marker: GMSMarker) {
        
    }
    
    
}

