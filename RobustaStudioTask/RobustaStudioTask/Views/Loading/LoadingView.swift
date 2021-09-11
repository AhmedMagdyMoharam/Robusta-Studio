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
    @IBOutlet weak var gitHubIcon: UIImageView!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var bgImage: UIImageView!
    
    //MARK: - Properties
    let ImageAlpha: CGFloat = 0.05 // alpha of the bg image 
    let characterDelayValue: Double = 5
    let showIconDelayValue = 1.5
    
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
        companyName.config(font: UIFont(name: AppFonts.boldHelvetica, size: 30) ?? UIFont(), color: ColorDesignSystem.Colors.black.color)
        companyName.setTextWithTypeAnimation(typedText: "Robusta Repos", characterDelay: characterDelayValue)
        
        //Icon
        gitHubIcon.image = ImagesDesignSystem.images.gitHubIcon.image
        gitHubIcon.contentMode = .scaleAspectFit
        gitHubIcon.alpha = 0
        showGitHubIcon()
        
        //BackGround image
        bgImage.image = ImagesDesignSystem.images.loadingPagePlaceHolder.image
        bgImage.contentMode = .scaleToFill
        bgImage.alpha = ImageAlpha
    }
    
    private func showGitHubIcon() {
        DispatchQueue.main.asyncAfter(deadline: .now() + showIconDelayValue) { [ weak self ] in
            guard let self = self else { return }
            UIView.animate(withDuration: 0.8) { [ weak self ] in
                guard let self = self else { return }
                self.gitHubIcon.alpha = 1
            }
            AnimationUtility.shared.viewSlideIn(view: self.gitHubIcon, direction: .fromBottom, CAMediaTimingFunctionName: .easeOut, kSlideAnimationDuration: 0.4)
        }
    }
}
