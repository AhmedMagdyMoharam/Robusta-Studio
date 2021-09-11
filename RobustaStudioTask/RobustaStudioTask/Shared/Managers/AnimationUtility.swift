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
    func animate(_ cell: UITableViewCell)
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
    
    func animate(_ cell: UITableViewCell) {
        cell.transform = CGAffineTransform(translationX: 0, y: 55)
        cell.layer.shadowColor = ColorDesignSystem.Colors.black.color.cgColor
        cell.layer.shadowOffset = CGSize(width: 10, height: 10)
        cell.alpha = 0
        UIView.animate(withDuration: 0.3) {
            cell.transform = CGAffineTransform(translationX: 0, y: 0)
            cell.alpha = 1
            cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        } completion: { _ in }
    }
}
