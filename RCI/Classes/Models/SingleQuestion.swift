//
//  SingleQuestion.swift
//  RCI
//
//  Created by Impulse on 13.02.17.
//  Copyright © 2017 Impulse. All rights reserved.
//

import Foundation

struct Answer : JSONJoy {
    let id:Int
    let text:String
    let order:Int
    let correct:Bool
    
    init(_ decoder: JSONDecoder) throws {
        id = try decoder["id"].get()
        text = try decoder["text"].get()
        order = try decoder["order"].get()
        correct = try decoder["correct"].get()
    }
}

struct SingleQuestion : JSONJoy {
    let id:Int
    let text:String
    let order:Int
    var selected:Int
    let answers:[Answer]
    
    init(_ decoder: JSONDecoder) throws {
        id = try decoder["id"].get()
        text = try decoder["text"].get()
        order = try decoder["order"].get()
        selected = -1
        let answersData:[Any] = try decoder["answers"].get()
        var answersLocal:[Answer] = []
        for object in answersData {
            do {
                do {
                    let answer = try Answer(object as! JSONDecoder)
                    answersLocal.append(answer)
                } catch {}
            }
        }
        answers = answersLocal
    }
}
