//
//  Questionnaires.swift
//  RCI
//
//  Created by Impulse on 13.02.17.
//  Copyright © 2017 Impulse. All rights reserved.
//

import Foundation

struct Questionnaires : JSONJoy {
    let id:Int
    let title:String
    let description:String
    let createdAt:String
    
    init(_ decoder: JSONDecoder) throws {
        id = try decoder["id"].get()
        title = try decoder["title"].get()
        description = try decoder["description"].get()
        createdAt = try decoder["created_at"].get()
    }
}
