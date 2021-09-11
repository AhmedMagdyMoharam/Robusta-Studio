//
//  LoadingView.swift
//  RobustaStudioTask
//
//  Created by ahmed moharam on 10/09/2021.
//

import Foundation
import UIKit

class LoadingView: UIView {
    
    //MARK: - Outlets
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var bgImage: UIImageView!
    
    //MARK: - Properties
    let ImageAlpha: CGFloat = 0.05 // alpha of the bg image 
    let characterDelayValue: Double = 5 // Delay of set character animation
    
    //MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        designSetup()
    }
    
    //MARK: - Methods
    private func designSetup() {
        //Base
        backgroundColor = ColorDesignSystem.Colors.appLightGray.color
        
        //Company name
        companyName.config(font: UIFont(name: AppFonts.boldHelvetica, size: 30) ?? UIFont(), color: ColorDesignSystem.Colors.appRed.color)
        companyName.setTextWithTypeAnimation(typedText: "Robusta Studio", characterDelay: characterDelayValue)
        
        //BackGround image
        bgImage.image = ImagesDesignSystem.backGroundImage.loadingPagePlaceHolder.image
        bgImage.contentMode = .scaleToFill
        bgImage.alpha = ImageAlpha
    }
}
