//
//  AppStateManager.swift
//  RobustaStudioTask
//
//  Created by ahmed moharam on 10/09/2021.
//

import Foundation
import Foundation
import UIKit

//MARK:- AppState Enum
enum AppState {
    case none
    case loggedIn
    case loading
}

protocol AppStateManagerProtocol {
    func start(appDelegate: AppDelegateProtocol)
    func switchState(to state: AppState)
}

class AppStateManager {
    //MARK:- Private Properties
    private var appDelegate: AppDelegateProtocol!
    private var transitionAnimationDuration: Float = 0.2
    private var mainWindow: UIWindow? {
        return self.appDelegate?.window
    }
    private var state: AppState = .none {
        willSet(newState) {
            switch newState {
            case .none:
                print("Skip")
            case .loggedIn:
                handleLoggedIn()
            case .loading:
                handleLoading()
            }
        }
    }
    
    //MARK:- Singleton
    static let shared: AppStateManagerProtocol = AppStateManager()
    
    
    //MARK:- Methods
    private func handleLoggedIn() {
    }
    
    private func handleLoading() {
    }
    
    private func switchRootWithAnimation(toVC: UIViewController) {
        var options = UIWindow.TransitionOptions(direction: .fade, style: .easeIn)
        options.background = UIWindow.TransitionOptions.Background.solidColor(.white)
        options.duration = TimeInterval(exactly: transitionAnimationDuration)!
        self.mainWindow?.setRootViewController(toVC, options: options)
    }
}
//MARK:- Protocol Conformance
extension AppStateManager: AppStateManagerProtocol {
    func start(appDelegate: AppDelegateProtocol) {
        self.appDelegate = appDelegate
        switchState(to: .loading)
    }
    
    func switchState(to state: AppState) {
        self.state = state
    }
}

