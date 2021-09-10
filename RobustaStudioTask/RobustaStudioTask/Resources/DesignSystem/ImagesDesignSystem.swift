//
//  ImagesDesignSystem.swift
//  RobustaStudioTask
//
//  Created by ahmed moharam on 10/09/2021.
//

import UIKit

/// I usually use Swift Gen
struct ImagesDesignSystem {
    
    enum backGroundImage: String {
        case firstBGImage = "First_bg"
        
        var image: UIImage {
            return UIImage(named: self.rawValue) ?? UIImage()
        }
    }
}


