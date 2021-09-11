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
    @IBOutlet weak var commentDetails: UILabel!
    @IBOutlet weak var createdAt: UILabel!
    
    //MARK: - Properties
    var data: RepositoryVMProtocol? {
        didSet {
            fetchRepoData()
        }
    }
    var followData: UserVMProtocol? {
        didSet {
            fetchFollowData()
        }
    }
    var commentsData: CommentVMProtocol? {
        didSet {
            fetchCommentData()
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
        repoName.config(font: UIFont(name: AppFonts.boldHelvetica, size: 15) ?? UIFont(), color: ColorDesignSystem.Colors.black.color)
        ownerName.config(font: UIFont(name: AppFonts.regularHelvetica, size: 14) ?? UIFont(), color: ColorDesignSystem.Colors.black.color)
        repoOwnerType.config(font: UIFont(name: AppFonts.regularHelvetica, size: 12) ?? UIFont(), color: ColorDesignSystem.Colors.gray.color)
        commentDetails.config(font: UIFont(name: AppFonts.regularHelvetica, size: 12) ?? UIFont(), color: ColorDesignSystem.Colors.gray.color, numberOfLines: 0)
        commentDetails.isHidden = true
        createdAt.config(font: UIFont(name: AppFonts.regularHelvetica, size: 10) ?? UIFont(), color: ColorDesignSystem.Colors.black.color)
        createdAt.isHidden = true
        repoTypeImage.image = ImagesDesignSystem.images.repoTypeIcon.image
    }
    
    // fetch repo data
    private func fetchRepoData() {
        fetchCustomInputs(repoTitle:  data?.name, userName: data?.owner?.ownerUserName ?? "", type: data?.owner?.typeType, imageURL: data?.owner?.avatarURL ?? "")
    }
    
    // fetch follow Data
    private func fetchFollowData() {
        ownerName.isHidden = true
        createdAt.isHidden = true
        commentDetails.isHidden = true
        fetchCustomInputs(repoTitle: followData?.ownerUserName, userName: nil, type: followData?.typeType, imageURL: followData?.avatarURL ?? "")
    }
    
    // fetch comment data
    private func fetchCommentData() {
        fetchCustomInputs(repoTitle: commentsData?.user?.ownerUserName ?? "", userName: nil, type: followData?.typeType, imageURL: commentsData?.user?.avatarURL ?? "")
        commentDetails.text = commentsData?.body
        ownerName.isHidden = true
        createdAt.isHidden = false
        commentDetails.isHidden = false
        createdAt.text = commentsData?.createdAt
    }
    
    private func fetchCustomInputs(repoTitle: String?, userName: String?, type: OwnerType?, imageURL: String) {
        repoName.text = repoTitle
        ownerName.text = userName
        type == .organization ? (repoOwnerType.text = "Organization") : (repoOwnerType.text = "User")
        downloadImage(url: imageURL)
    }
    
    // Download + Caching
    private func downloadImage(url: String) {
        if let url = URL(string: url) {
            ownerAvatar.loadImageWithUrl(url)
        } else {
            ownerAvatar.image = ImagesDesignSystem.images.userPlaceHolder.image
        }
    }
}
