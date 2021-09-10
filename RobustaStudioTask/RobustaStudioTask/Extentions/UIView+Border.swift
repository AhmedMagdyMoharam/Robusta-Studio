//
//  UIView+Border.swift
//  RobustaStudioTask
//
//  Created by ahmed moharam on 10/09/2021.
//

import Foundation
import UIKit

extension UIView {
    func addBorder(radius: CGFloat = 1, color: UIColor) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = radius
    }
    
    func removeBorder() {
        self.layer.borderWidth = 0.0
    }
}

