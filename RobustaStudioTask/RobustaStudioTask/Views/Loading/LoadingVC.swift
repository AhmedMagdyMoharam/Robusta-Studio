//
//  LoadingVC.swift
//  RobustaStudioTask
//
//  Created by ahmed moharam on 10/09/2021.
//

import Foundation
import UIKit
import Combine

class LoadingVC: UIViewController {
    
    
    //MARK: - Outlets
    @IBOutlet var mainView: LoadingView!
    
    //MARK: - Properties
    private var subscriptions = Set<AnyCancellable>()
    
    //MARK: - Init & dealloc methods
    deinit {
        print("DeInit called: \(String(describing: self))")
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        switchAppState()
    }
    //MARK: - Methods
    /// Dependency injection of LoadingVC
    class func create() -> LoadingVC {
        let vc: LoadingVC = StoryBoardDesignSystem.StoryBoard.main.name.instantiateViewController(identifier: "\(LoadingVC.self)")
        return vc
    }
    
    private func switchAppState() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            AppStateManager.shared.switchState(to: .loggedIn)
        }
    }
}
