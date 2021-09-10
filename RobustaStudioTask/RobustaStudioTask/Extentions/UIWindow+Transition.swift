//
//  UIWindow+Transition.swift
//  RobustaStudioTask
//
//  Created by ahmed moharam on 10/09/2021.
//

import UIKit

extension UIWindow {
    
    /// Transition Options
    struct TransitionOptions {
        
        /// Curve of animation
        public enum Curve {
            case linear
            case easeIn
            case easeOut
            case easeInOut
            
            /// Return the media timing function associated with curve
            internal var function: CAMediaTimingFunction {
                let key: CAMediaTimingFunctionName!
                switch self {
                case .linear:        key = CAMediaTimingFunctionName.linear
                case .easeIn:        key = CAMediaTimingFunctionName.easeIn
                case .easeOut:        key = CAMediaTimingFunctionName.easeOut
                case .easeInOut:    key = CAMediaTimingFunctionName.easeInEaseOut
                }
                return CAMediaTimingFunction(name: key)
            }
        }
        
        /// Direction of the animation
        enum Direction {
            case fade
            case toTop
            case toBottom
            case toLeft
            case toRight
            
            /// Return the associated transition
            internal func transition() -> CATransition {
                let transition = CATransition()
                transition.type = CATransitionType.push
                switch self {
                case .fade:
                    transition.type = CATransitionType.fade
                    transition.subtype = nil
                case .toLeft:
                    transition.subtype = CATransitionSubtype.fromLeft
                case .toRight:
                    transition.subtype = CATransitionSubtype.fromRight
                case .toTop:
                    transition.subtype = CATransitionSubtype.fromTop
                case .toBottom:
                    transition.subtype = CATransitionSubtype.fromBottom
                }
                return transition
            }
        }
        
        /// Background of the transition
        ///
        /// - solidColor: solid color
        /// - customView: custom view
        public enum Background {
            case solidColor(_: UIColor)
            case customView(_: UIView)
        }
        
        /// Duration of the animation (default is 0.20s)
        public var duration: TimeInterval = 0.20
        
        /// Direction of the transition (default is `toRight`)
        public var direction: TransitionOptions.Direction = .toRight
        
        /// Style of the transition (default is `linear`)
        public var style: TransitionOptions.Curve = .linear
        
        /// Background of the transition (default is `nil`)
        public var background: TransitionOptions.Background? = nil
        
        /// Initialize a new options object with given direction and curve
        public init(direction: TransitionOptions.Direction = .toRight, style: TransitionOptions.Curve = .linear) {
            self.direction = direction
            self.style = style
        }
        
        public init() { }
        
        /// Return the animation to perform for given options object
        internal var animation: CATransition {
            let transition = self.direction.transition()
            transition.duration = self.duration
            transition.timingFunction = self.style.function
            return transition
        }
    }
    
    
    /// Change the root view controller of the window
    func setRootViewController(_ controller: UIViewController, options: TransitionOptions = TransitionOptions()) {
        
        var transitionWindow: UIWindow? = nil
        if let background = options.background {
            transitionWindow = UIWindow(frame: UIScreen.main.bounds)
            switch background {
            case .customView(let view):
                transitionWindow?.rootViewController = UIViewController.newController(withView: view, frame: transitionWindow!.bounds)
            case .solidColor(let color):
                transitionWindow?.backgroundColor = color
            }
            transitionWindow?.makeKeyAndVisible()
        }
        
        // Make animation
        self.layer.add(options.animation, forKey: kCATransition)
        self.rootViewController = controller
        self.makeKeyAndVisible()
        
        if let wnd = transitionWindow {
            DispatchQueue.main.asyncAfter(deadline: (.now() + 1 + options.duration), execute: {
                wnd.removeFromSuperview()
            })
        }
    }
}

internal extension UIViewController {
    static func newController(withView view: UIView, frame: CGRect) -> UIViewController {
        view.frame = frame
        let controller = UIViewController()
        controller.view = view
        return controller
    }
}

extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}

