//
//  UIElement+Config.swift
//  RobustaStudioTask
//
//  Created by ahmed moharam on 10/09/2021.
//

import Foundation
import UIKit

extension UILabel {
    func config(font: UIFont, color: UIColor, text: String? = nil, numberOfLines: Int = 1) {
        self.font = font
        self.textColor = color
        self.text = text
        self.numberOfLines = numberOfLines
    }
}

extension UIButton {
    func config(font: UIFont, color: UIColor, text: String? = nil, backgroundColor: UIColor? = nil, image: UIImage? = nil, cornerRadius: CGFloat = 0) {
        self.titleLabel?.font = font
        self.setTitle(text, for: .normal)
        self.setTitleColor(color, for: .normal)
        self.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        if let _ = image {
            let insetAmount: CGFloat = 10
            let factor: CGFloat =  1
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount*factor, bottom: 0, right: insetAmount*factor)
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount*factor, bottom: 0, right: -insetAmount*factor)
            self.contentEdgeInsets = UIEdgeInsets(top: self.contentEdgeInsets.top, left: insetAmount, bottom: self.contentEdgeInsets.bottom, right: insetAmount)
        }
        self.backgroundColor = backgroundColor
        self.setCornerRadius(radius: cornerRadius)
    }
}

extension UITextView {
    func config(font: UIFont, color: UIColor, text: String? = nil) {
        self.font = font
        self.textColor = color
        self.text = text
    }
}

extension UITextField {
    func config(font: UIFont, color: UIColor, text: String? = nil) {
        self.font = font
        self.textColor = color
        self.text = text
    }
}
