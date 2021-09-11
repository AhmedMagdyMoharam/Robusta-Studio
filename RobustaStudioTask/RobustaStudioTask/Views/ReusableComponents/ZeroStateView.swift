//
//  ZeroStateView.swift
//  RobustaStudioTask
//
//  Created by ahmed moharam on 11/09/2021.
//

import Foundation
import UIKit

class ZeroStateView: UIView {
    //MARK:- Outlet
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var zeroStateIcon: UIImageView!
    @IBOutlet weak var zeroStateTitle: UILabel!
    @IBOutlet weak var zeroStateBody: UILabel!
    
    //MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("\(ZeroStateView.self)", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        setup()
    }
    
    //MARK:- Methods
    private func setup() {
        zeroStateTitle.config(font: UIFont(name: AppFonts.boldHelvetica, size: 15) ?? UIFont(), color: ColorDesignSystem.Colors.appRed.color)
        zeroStateTitle.textAlignment = .center
        zeroStateBody.config(font: UIFont(name: AppFonts.regularHelvetica, size: 14) ?? UIFont(), color: ColorDesignSystem.Colors.inputDarkerGray.color, numberOfLines: 2)
        zeroStateBody.textAlignment = .center
    }
    
    func customSetup(title: String, body: String?, icon: UIImage? = ImagesDesignSystem.images.zeroStateRepos.image) {
        zeroStateTitle.text = title
        icon != nil ? (zeroStateIcon.image = icon) : (zeroStateIcon.isHidden = true)
        body != nil ? (zeroStateBody.text = body) : (zeroStateBody.isHidden = true)
    }
}
