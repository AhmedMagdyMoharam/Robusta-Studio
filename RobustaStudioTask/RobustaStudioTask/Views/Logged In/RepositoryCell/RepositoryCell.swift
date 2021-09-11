//
//  RepositoryCell.swift
//  RobustaStudioTask
//
//  Created by ahmed moharam on 11/09/2021.
//

import UIKit

class RepositoryCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var ownerAvatar: ImageLoader!
    @IBOutlet weak var repoName: UILabel!
    @IBOutlet weak var ownerName: UILabel!
    @IBOutlet weak var repoTypeImage: UIImageView!
    @IBOutlet weak var repoOwnerType: UILabel!
    
    //MARK: - Properties
    var data: RepositoryVMProtocol? {
        didSet {
            fetchRepoData()
        }
    }
    
    //MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        designSetup()
    }
    
    //MARK: - Methods
    private func designSetup() {
        // Base
        backgroundColor = .clear
        selectionStyle = .none
        
        // owner avatar
        ownerAvatar.circulate()
        ownerAvatar.contentMode = .scaleToFill
        
        //bodySetup
        repoName.config(font: UIFont(name: AppFonts.boldHelvetica, size: 15) ?? UIFont(), color: ColorDesignSystem.Colors.inputDarkerGray.color)
        ownerName.config(font: UIFont(name: AppFonts.regularHelvetica, size: 14) ?? UIFont(), color: ColorDesignSystem.Colors.black.color)
        repoOwnerType.config(font: UIFont(name: AppFonts.regularHelvetica, size: 12) ?? UIFont(), color: ColorDesignSystem.Colors.gray.color)
        repoTypeImage.image = ImagesDesignSystem.backGroundImage.repoTypeIcon.image
    }
    
    private func fetchRepoData() {
        guard let data = data else { return }
        //bodySetup
        repoName.text = data.name
        ownerName.text = data.owner?.ownerName
        data.owner?.type == .organization ? (repoOwnerType.text = "Organization") : (repoOwnerType.text = "User")
        
        // user avatar
        if let url = URL(string: data.owner?.avatarURL ?? "") {
            ownerAvatar.loadImageWithUrl(url)
        } else {
            ownerAvatar.image = ImagesDesignSystem.backGroundImage.userPlaceHolder.image
        }
    }
}
