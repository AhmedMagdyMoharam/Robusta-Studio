//
//  HapticManager.swift
//  RobustaStudioTask
//
//  Created by ahmed moharam on 10/09/2021.
//

import Foundation
import UIKit
import AVFoundation

//MARK: - HapticFeedBackProtocol
protocol HapticFeedBackProtocol {
    func feedBackVibrationResponse(style: UINotificationFeedbackGenerator.FeedbackType)
    func feedBackVibration(style: UIImpactFeedbackGenerator.FeedbackStyle)
}

class HapticFeedBack: HapticFeedBackProtocol {
    
    //MARK: - singelton
    static var shared: HapticFeedBackProtocol = HapticFeedBack()
    
    //MARK: - Methods
    func feedBackVibrationResponse(style: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(style)
    }
    
    func feedBackVibration(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.prepare()
        generator.impactOccurred()
    }
}
