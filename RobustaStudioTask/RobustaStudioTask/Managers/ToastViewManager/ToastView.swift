//
//  ToastView.swift
//  RobustaStudioTask
//
//  Created by ahmed moharam on 10/09/2021.
//


import UIKit

class ToastView: UIView {
    
    //MARK: - Outlets
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    
    //MARK: - Properties
    var viewHeight: CGFloat {
        let textString = (errorLabel.text ?? "") as NSString
        let textAttributes: [NSAttributedString.Key: Any] = [.font: errorLabel.font!]
        let estimatedTextHeight = textString.boundingRect(with: CGSize(width: errorLabel.frame.width - 40, height: 2000), options: .usesLineFragmentOrigin, attributes: textAttributes, context: nil).height
        let height = estimatedTextHeight
        return height
    }
    
    //MARK: - Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("ToastView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
    }
}
