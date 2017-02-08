//
//  TextViewColor.swift
//  RCI
//
//  Created by Impulse on 09.02.17.
//  Copyright © 2017 Impulse. All rights reserved.
//

import Foundation
import UIKit

extension String
{
    func htmlFormattedString(font:UIFont, color: UIColor) -> String
    {
        let numberOfColorComponents:Int = color.cgColor.numberOfComponents
        let colorComponents = color.cgColor.components
        
        var colorHexString = ""
        if numberOfColorComponents == 4 {
            let red = (colorComponents?[0])! * 255
            let green = (colorComponents?[1])! * 255
            let blue = (colorComponents?[2])! * 255
            
            colorHexString = NSString(format:"%02X%02X%02X", Int(red), Int(green), Int(blue)) as String
        } else if numberOfColorComponents == 2 {
            let white = (colorComponents?[0])! * 255
            
            colorHexString = NSString(format:"%02X%02X%02X", Int(white), Int(white), Int(white)) as String
        } else {
            return "Color format noch supported"
        }
        
        return NSString(format: "<html>\n <head>\n <style type=\"text/css\">\n body {font-family: \"%@\"; font-size: %@; color:#%@;}\n </style>\n </head>\n <body>%@</body>\n </html>", font.familyName, String(stringInterpolationSegment: font.pointSize), colorHexString, self) as String
    }
}
