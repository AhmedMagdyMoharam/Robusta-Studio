//
//  UIViewController + Swizzle.swift
//  RobustaStudioTask
//
//  Created by ahmed moharam on 11/09/2021.
//

import Foundation
import UIKit

extension UIViewController {
    
    static func swizzleViewDidLoad() {
    //Make sure This isn't a subclass of UIViewController, So that It applies to all UIViewController childs
        if self != UIViewController.self {
            return
        }
        let originalSelector = #selector(UIViewController.viewDidLoad)
        let swizzledSelector = #selector(UIViewController.viewDidLoadOverride)
        guard let originalMethod = class_getInstanceMethod(self, originalSelector),
            let swizzledMethod = class_getInstanceMethod(self, swizzledSelector) else { return }
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
    
    @objc func viewDidLoadOverride() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
