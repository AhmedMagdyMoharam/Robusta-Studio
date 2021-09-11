//
//  RepoDescriptionView.swift
//  RobustaStudioTask
//
//  Created by ahmed moharam on 11/09/2021.
//

import Foundation
import UIKit

class RepoDescriptionView: UIView {
    
    //MARK: - Outlets
    @IBOutlet weak var repoDescriptionTableView: UITableView!
    @IBOutlet weak var tableHeader: UIView!
    
    @IBOutlet weak var ownerAvatar: ImageLoader!
    @IBOutlet weak var ownerName: UILabel!
    @IBOutlet weak var ownerUserName: UILabel!
    @IBOutlet weak var repoName: UILabel!
    
    @IBOutlet weak var privateIcon: UIImageView!
    @IBOutlet weak var privateTitle: UILabel!
    @IBOutlet weak var forkStack: UIStackView!
    @IBOutlet weak var forkImage: UIImageView!
    @IBOutlet weak var forkTitle: UILabel!
    @IBOutlet weak var repoTypeImage: UIImageView!
    @IBOutlet weak var repoOwnerTitle: UILabel!
    
    @IBOutlet weak var descriptionConstrainHeight: NSLayoutConstraint!
    @IBOutlet weak var repoDescription: UILabel!
    @IBOutlet weak var gitHubLinkStack: UIStackView!
    @IBOutlet weak var gitHubIcon: UIImageView!
    @IBOutlet weak var repoLink: UILabel!
    @IBOutlet weak var locationIcon: UIImageView!
    @IBOutlet weak var locationTitle: UILabel!
    
    @IBOutlet weak var createAtTitle: UILabel!
    @IBOutlet weak var createAtValue: UILabel!
    
    // Three native tabs
    @IBOutlet weak var commentsButton: UIButton!
    @IBOutlet weak var followingButton: UIButton!
    @IBOutlet weak var followersButton: UIButton!
    @IBOutlet weak var selectionIndicatorView: UIView!
    @IBOutlet weak var selectionIndicatorConstraint: NSLayoutConstraint!
    
    //MARK: - Properties
    private var viewModel: RepoDescriptionViewModel?
    
    //MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        designSetup()
    }
    
    //MARK: - Methods
    private func designSetup() {
        //Header Design Setup
        headerSetup()
        //TableView Setup
        setupRepositoriesTable()
    }
    
    private func headerSetup() {
        // owner avatar
        ownerAvatar.circulate()
        ownerAvatar.contentMode = .scaleToFill
        repoDescriptionTableView.isHidden = true
        
        //bodySetup
        ownerName.config(font: UIFont(name: AppFonts.regularHelvetica, size: 13) ?? UIFont(), color: ColorDesignSystem.Colors.black.color)
        ownerUserName.config(font: UIFont(name: AppFonts.regularHelvetica, size: 11) ?? UIFont(), color: ColorDesignSystem.Colors.gray.color)
        repoName.config(font: UIFont(name: AppFonts.boldHelvetica, size: 18) ?? UIFont(), color: ColorDesignSystem.Colors.black.color)

        privateIcon.image = ImagesDesignSystem.images.privateIcon.image
        privateTitle.config(font: UIFont(name: AppFonts.regularHelvetica, size: 12) ?? UIFont(), color: ColorDesignSystem.Colors.gray.color)
        forkImage.image = ImagesDesignSystem.images.forkIcon.image
        forkTitle.config(font: UIFont(name: AppFonts.regularHelvetica, size: 12) ?? UIFont(), color: ColorDesignSystem.Colors.gray.color)
        repoTypeImage.image = ImagesDesignSystem.images.repoTypeIcon.image
        repoOwnerTitle.config(font: UIFont(name: AppFonts.regularHelvetica, size: 12) ?? UIFont(), color: ColorDesignSystem.Colors.gray.color)
        repoDescription.config(font: UIFont(name: AppFonts.regularHelvetica, size: 12) ?? UIFont(), color: ColorDesignSystem.Colors.inputDarkerGray.color, numberOfLines: 0)
        repoLink.config(font: UIFont(name: AppFonts.regularHelvetica, size: 12) ?? UIFont(), color: ColorDesignSystem.Colors.linkBlue.color)
        gitHubIcon.image = ImagesDesignSystem.images.gitHubIcon.image
        locationIcon.image = ImagesDesignSystem.images.locationIcon.image
        locationTitle.config(font: UIFont(name: AppFonts.regularHelvetica, size: 12) ?? UIFont(), color: ColorDesignSystem.Colors.gray.color)
        gitHubLinkStack.isUserInteractionEnabled = true
        
        createAtTitle.config(font: UIFont(name: AppFonts.regularHelvetica, size: 12) ?? UIFont(), color: ColorDesignSystem.Colors.black.color, text: "Created at:")
        createAtValue.config(font: UIFont(name: AppFonts.regularHelvetica, size: 11) ?? UIFont(), color: ColorDesignSystem.Colors.inputDarkerGray.color)
        
        // Three tabs
        commentsButton.config(font: UIFont(name: AppFonts.regularHelvetica, size: 15) ?? UIFont(), color: ColorDesignSystem.Colors.gray.color, text: "Comments")
        commentsButton.setTitleColor(ColorDesignSystem.Colors.appRed.color, for: .selected)
        commentsButton.tintColor = .clear
        commentsButton.isSelected = viewModel?.pageType.value == .comments
        followingButton.config(font: UIFont(name: AppFonts.regularHelvetica, size: 15) ?? UIFont(), color: ColorDesignSystem.Colors.gray.color, text: "Following")
        followingButton.setTitleColor(ColorDesignSystem.Colors.appRed.color, for: .selected)
        followingButton.tintColor = .clear
        followingButton.isSelected = viewModel?.pageType.value == .following
        followersButton.config(font: UIFont(name: AppFonts.regularHelvetica, size: 15) ?? UIFont(), color: ColorDesignSystem.Colors.gray.color, text: "Followers")
        followersButton.setTitleColor(ColorDesignSystem.Colors.appRed.color, for: .selected)
        followersButton.tintColor = .clear
        followersButton.isSelected = viewModel?.pageType.value == .followers
        selectionIndicatorView.backgroundColor = ColorDesignSystem.Colors.appRed.color
    }
    
    private func setupRepositoriesTable() {
        repoDescriptionTableView.backgroundColor = .clear
        repoDescriptionTableView.separatorStyle = .none
        repoDescriptionTableView.showsVerticalScrollIndicator = false
        repoDescriptionTableView.showsHorizontalScrollIndicator = false
        repoDescriptionTableView.register(UINib(nibName: "\(RepositoryCell.self)", bundle: nil), forCellReuseIdentifier: "\(RepositoryCell.self)")
    }
    
    //MARK:- Update Three tabs
    func updateTabsUI(for dataSource: RepoDescriptionViewModel.pageType) {
        commentsButton.isSelected = dataSource == .comments
        followingButton.isSelected = dataSource == .following
        followersButton.isSelected = dataSource == .followers
        
        switch dataSource {
        case .comments:
            selectionIndicatorConstraint.constant = 0
        case .following:
            selectionIndicatorConstraint.constant = followingButton.frame.midX - commentsButton.frame.midX
        case .followers:
            selectionIndicatorConstraint.constant = followersButton.frame.midX - commentsButton.frame.midX
        }
        
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.layoutIfNeeded()
        }
    }
    
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text

        label.sizeToFit()
        return label.frame.height
    }
    
    func fetchRepoData(repoData: RepositoryVMProtocol, user: UserVMProtocol) {
        repoName.text = repoData.fullRepoName
        privateTitle.text = repoData.topicPrivate
        forkStack.isHidden = !(repoData.fork ?? false)
        ownerName.text = user.name
        ownerUserName.text = user.ownerUserName
        user.typeType == .organization ? (repoOwnerTitle.text = "Organization") : (repoOwnerTitle.text = "User")
        repoLink.text = user.gitHubRepoLink
        createAtValue.text = user.createdAt
        locationTitle.text = user.location
        if let descriptionText = try? repoData.topicDescription?.strippingHTML() {
            repoDescription.text = descriptionText
            descriptionConstrainHeight.constant = heightForView(text: descriptionText, font: UIFont(name: AppFonts.regularHelvetica, size: 12) ?? UIFont(), width: frame.width) }
        // user avatar
        if let url = URL(string: user.avatarURL ?? "") {
            ownerAvatar.loadImageWithUrl(url)
        } else {
            ownerAvatar.image = ImagesDesignSystem.images.userPlaceHolder.image
        }
        repoDescriptionTableView.updateHeaderViewHeight()
        repoDescriptionTableView.isHidden = false
    }
}
