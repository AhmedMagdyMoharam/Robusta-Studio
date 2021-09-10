//
//  ToastManager.swift
//  RobustaStudioTask
//
//  Created by ahmed moharam on 10/09/2021.
//


import Foundation
import UIKit

class ToastManager {
    
    //MARK: - Internal Enums
    enum ToastStatus {
        case success
        case failure
        case info
        case warning
        case internetConnection
        
        var rawValue: UIColor {
            switch self {
            case .success: return ColorDesignSystem.Colors.emerald.color
            case .failure: return ColorDesignSystem.Colors.bittersweet.color
            case .info: return ColorDesignSystem.Colors.dodgerBlue.color
            case .warning: return ColorDesignSystem.Colors.creamCan.color
            case .internetConnection: return ColorDesignSystem.Colors.gray.color
            }
        }
    }
    
    //MARK: - Properties
    static let shared = ToastManager()
    private var view: UIView = UIView()
    private var message: String = ""
    private var bGColor: UIColor?
    private var topAnchor: NSLayoutConstraint!
    private var viewHeight: CGFloat = 0
    private var errorHeaders: [ToastView?] = []
    
    //MARK: - Methods
    private init() {}
    
    func showError(message: String, status: ToastStatus) {
        let errorHeader: ToastView? = ToastView()
        errorHeaders.forEach({
            hideBanner(errorHeader: $0)
        })
        errorHeaders.append(errorHeader)
        vibrationSetup(status: status)
        self.view = UIWindow.key?.rootViewController?.view ?? UIView()
        self.bGColor = status.rawValue
        self.message = message
        createBannerWithInitialPosition(errorHeader: errorHeader)
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [weak self] in
            self?.hideBanner(errorHeader: errorHeader)
        }
    }
    
    private func createBannerWithInitialPosition(errorHeader: ToastView?) {
        guard let errorHeader = errorHeader else { return }
        errorHeader.errorLabel.text = message
        errorHeader.contentView.backgroundColor = bGColor
        errorHeader.layer.shadowRadius = 1
        errorHeader.layer.shadowOpacity = 0.5
        errorHeader.layer.shadowOffset = CGSize(width: 1, height: 1)
        view.addSubview(errorHeader)
        let guide = view.safeAreaLayoutGuide
        errorHeader.translatesAutoresizingMaskIntoConstraints = false
        topAnchor = errorHeader.bottomAnchor.constraint(equalTo: guide.topAnchor, constant: -(errorHeader.viewHeight + 60))
        topAnchor.isActive = true
        errorHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        errorHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        errorHeader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        errorHeader.heightAnchor.constraint(equalToConstant: errorHeader.viewHeight + 80).isActive = true
        viewHeight = errorHeader.viewHeight + 35
        view.layoutIfNeeded()
        animateBannerPresentation()
    }
    
    private func animateBannerPresentation() {
        topAnchor.constant = viewHeight
        UIView.animate(withDuration: 0.5, delay: 0.3, options: [], animations: { [weak self] in self?.view.layoutIfNeeded() }, completion: nil)
    }
    
    private func hideBanner(errorHeader: ToastView?) {
        UIView.animate(withDuration: 0.5, animations: {
            errorHeader?.alpha = 0
        }) { [weak self] _ in
            guard let _ = self else { return }
            errorHeader?.removeFromSuperview()
        }
    }
    
    /// Haptic Feed back 
    private func vibrationSetup(status: ToastStatus) {
        switch status {
        case .success:
            HapticFeedBack.shared.feedBackVibrationResponse(style: .success)
        case .failure:
            HapticFeedBack.shared.feedBackVibrationResponse(style: .error)
        default:
            HapticFeedBack.shared.feedBackVibrationResponse(style: .warning)
        }
    }
}
