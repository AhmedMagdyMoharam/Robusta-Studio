//
//  AnimationUtility.swift
//  RobustaStudioTask
//
//  Created by ahmed moharam on 11/09/2021.
//

import Foundation
import UIKit

protocol AnimationUtilityProtocol {
    func viewSlideIn(view: UIView, direction: CATransitionSubtype, CAMediaTimingFunctionName: CAMediaTimingFunctionName, kSlideAnimationDuration: CFTimeInterval)
}

class AnimationUtility: UIViewController, CAAnimationDelegate, AnimationUtilityProtocol {
    
    //MARK: - Singelton
    static let shared: AnimationUtilityProtocol = AnimationUtility()
    
    //MARK: - Method
    func viewSlideIn(view: UIView, direction: CATransitionSubtype, CAMediaTimingFunctionName: CAMediaTimingFunctionName, kSlideAnimationDuration: CFTimeInterval = 0.4) {
        var transition: CATransition? = nil
        transition = CATransition.init()
        transition?.duration = kSlideAnimationDuration
        transition?.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName)
        transition?.type = CATransitionType.push
        transition?.subtype = direction
        view.layer.add(transition!, forKey: nil)
    }
}
