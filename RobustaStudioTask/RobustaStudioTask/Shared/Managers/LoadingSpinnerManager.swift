//
//  LoadingSpinnerManager.swift
//  RobustaStudioTask
//
//  Created by ahmed moharam on 10/09/2021.
//

import Foundation
import UIKit

//MARK: - LoadingSpinnerProtocol
protocol LoadingSpinnerProtocol {
    func showGeneral()
    func hide()
}

class LoadingSpinnerManager: LoadingSpinnerProtocol {
    //MARK: Properties
    private var loadingSpinner = UIActivityIndicatorView(style: .large)
    private var containerView: UIView = UIView()
    private var isLoading: Bool = false
    private let screenBound = UIScreen.main.bounds
    
    //MARK: Singleton
    static let shared: LoadingSpinnerProtocol = LoadingSpinnerManager()
    
    //MARK: Methods
    func showGeneral() {
        guard isLoading == false else {return}
        isLoading = true
        guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return }
        loadingSpinner = UIActivityIndicatorView(style: .medium)
        containerView = UIView(frame: window.bounds)
        let position = CGRect(x: screenBound.width / 2 - 25, y: screenBound.height / 2 - 25, width: 50, height: 50)
        
        containerView.frame = position
        containerView.backgroundColor = .clear
        containerView.alpha = 0.7
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 10
        
        loadingSpinner.bounds = position
        loadingSpinner.center = containerView.center
        loadingSpinner.color =  .red
        containerView.addSubview(loadingSpinner)
        window.addSubview(containerView)
        loadingSpinner.startAnimating()
    }
    
    func hide() {
        loadingSpinner.removeFromSuperview()
        containerView.removeFromSuperview()
        isLoading = false
    }
}

