//
//  UINavigation+Transparent.swift
//  RobustaStudioTask
//
//  Created by ahmed moharam on 10/09/2021.
//

import Foundation
import Combine

import Foundation
import UIKit

extension UINavigationController {
    
    //MARK: - Methods
    func addColorWithBackImage(image: UIImage, color: UIColor = .white) {
        self.navigationBar.barTintColor = color
        self.navigationBar.isTranslucent = true
        self.navigationBar.setValue(true, forKey: "hidesShadow")
        let backImage = image.withRenderingMode(.alwaysOriginal)
        self.navigationBar.backIndicatorImage = backImage
        self.navigationBar.backIndicatorTransitionMaskImage = backImage
    }
    
    func makeNavTransparent() {
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        self.view.backgroundColor = .clear
    }
    
    func titleFontAndSize(font: UIFont = UIFont(name: AppFonts.regularHelvetica, size: 22) ?? UIFont()){
        let attributes = [NSAttributedString.Key.font: font]
        UINavigationBar.appearance().titleTextAttributes = attributes
    }
}

extension UINavigationItem {
    func addTitle(with image: UIImage) {
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: 144, height: 24)
        self.titleView = imageView
    }
}
