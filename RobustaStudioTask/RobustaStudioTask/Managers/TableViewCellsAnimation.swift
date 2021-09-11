//
//  TableViewCellsAnimation.swift
//  RobustaStudioTask
//
//  Created by ahmed moharam on 11/09/2021.
//

import Foundation
import UIKit

protocol TableViewCellsAnimationProtocol {
    func animate(_ cell: UITableViewCell)
}

class TableViewCellsAnimation: TableViewCellsAnimationProtocol {
    
    //MARK:- Singleton
    static var shared: TableViewCellsAnimationProtocol = TableViewCellsAnimation()
    
    //MARK: - Methods
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
