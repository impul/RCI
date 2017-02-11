//
//  AccidentInstructions.swift
//  RCI
//
//  Created by Impulse on 11.02.17.
//  Copyright © 2017 Impulse. All rights reserved.
//

struct AccidentInstructions : JSONJoy {
    let id:Int
    let title:String
    let tabs:Bool
    let firstTitle:String
    let firstContent:String
    let secondTitle:String
    let secondContent:String
    
    init(_ decoder: JSONDecoder) throws {
        id = try decoder["id"].get()
        title = try decoder["title"].get()
        tabs = try decoder["tabs"].get()
        firstTitle = try decoder["tab_1_title"].get()
        firstContent = try decoder["tab_1_content"].get()
        secondTitle = try decoder["tab_2_title"].get()
        secondContent = try decoder["tab_2_content"].get()
    }
}
