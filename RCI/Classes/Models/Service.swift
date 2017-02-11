//
//  Service.swift
//  RCI
//
//  Created by Impulse on 09.02.17.
//  Copyright © 2017 Impulse. All rights reserved.
//

import Foundation

struct Service : JSONJoy {
    let id:Int
    let title:String
    let website:String
    let type:String
    let description:String
    
    init(_ decoder: JSONDecoder) throws {
        id = try decoder["id"].get()
        title = try decoder["title"].get()
        website = try decoder["website"].get()
        type = try decoder["type"].get()
        description = try decoder["description"].get()
    }
}
