//
//  ColorDesignSystem.swift
//  RobustaStudioTask
//
//  Created by ahmed moharam on 10/09/2021.
//

import UIKit

/// I usually use Swift Gen (fonts, images, storyboards)
struct ColorDesignSystem {
    
    enum Colors: String {
        // App Colors
        case white = "White"
        case appRed = "WellRead"
        case appLightGray = "Gallery"
        case inputDarkerGray = "inputCharcoalDarker"
        case black = "Black"
        case linkBlue = "LinkBlue"
        
        // Toast Colors
        case bittersweet = "Bittersweet"
        case creamCan = "CreamCan"
        case dodgerBlue = "DodgerBlue"
        case emerald = "Emerald"
        case gray = "Gray"
        
        var color: UIColor {
            return UIColor(named: self.rawValue) ?? UIColor()
        }
    }
}
