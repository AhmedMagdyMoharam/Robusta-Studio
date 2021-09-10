//
//  AppDelegate.swift
//  RobustaStudioTask
//
//  Created by ahmed moharam on 10/09/2021.
//

import UIKit

protocol AppDelegateProtocol: AnyObject {
    var window: UIWindow? { get }
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate, AppDelegateProtocol {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // override Dark Mode
        window?.overrideUserInterfaceStyle = .light
        
        // Start App
        AppStateManager.shared.start(appDelegate: self)
        
        return true
    }
}

