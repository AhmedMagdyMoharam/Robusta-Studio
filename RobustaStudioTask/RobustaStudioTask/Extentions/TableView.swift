//
//  TableViewCellsAnimation.swift
//  RobustaStudioTask
//
//  Created by ahmed moharam on 11/09/2021.
//

import Foundation
import UIKit

class LoadingContainer: UIView {}

extension UIView {
    
    //MARK: - Methods
    func startImbeddedLoading(withBg: UIColor = .white, loaderColor: UIColor = .gray) {
        let loadingSpinner: UIActivityIndicatorView = UIActivityIndicatorView()
        let containerView: LoadingContainer = LoadingContainer()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = withBg
        loadingSpinner.translatesAutoresizingMaskIntoConstraints = false
        loadingSpinner.color = loaderColor
        self.addSubview(containerView)
        containerView.addSubview(loadingSpinner)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            loadingSpinner.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loadingSpinner.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        loadingSpinner.startAnimating()
        self.layoutIfNeeded()
    }
    
    func stopImbeddedLoading() {
        for subview in self.subviews {
            if let containerView = subview as? LoadingContainer {
                containerView.removeFromSuperview()
                return
            }
        }
    }
}

extension UITableView {
    func updateHeaderViewHeight() {
        if let header = self.tableHeaderView {
            let newSize = header.systemLayoutSizeFitting(CGSize(width: self.bounds.width, height: 0))
            header.frame.size.height = newSize.height
        }
    }
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: AppFonts.regularHelvetica, size: 15)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .none
    }
}
