//
//  HTTPDictionary.swift
//  RCI
//
//  Created by Impulse on 09.02.17.
//  Copyright © 2017 Impulse. All rights reserved.
//

import Foundation


extension Dictionary {
    
    func stringFromHttpParameters() -> String {
        let parameterArray = self.map { (key, value) -> String in
            return "\(key)=\(value)"
        }
        return parameterArray.joined(separator: "&")
    }
    
}
