//
//  BranchesPoint.swift
//  RCI
//
//  Created by Impulse on 12.02.17.
//  Copyright © 2017 Impulse. All rights reserved.
//

import Foundation

struct BranchesPoint : JSONJoy {
    
    let id:Int
    let title:String
    let address:String
    let phone:String
    let fax:String
    let email:String
    let postal_code:String
    let latitude:Double
    let longitude:Double
    
    init(_ decoder: JSONDecoder) throws {
        id = try decoder["id"].get()
        title = try decoder["title"].get()
        address = try decoder["address"].get()
        phone = try decoder["phone"].get()
        fax = try decoder["fax"].get()
        email = try decoder["email"].get()
        postal_code = try decoder["postal_code"].get()
        latitude = try decoder["latitude"].get()
        longitude = try decoder["longitude"].get()
    }
}
