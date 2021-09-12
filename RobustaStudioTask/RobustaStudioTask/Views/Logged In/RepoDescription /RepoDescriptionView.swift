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
    @IBOutlet var headerIcons: [UIImageView]!
    @IBOutlet weak var createAtTitle: UILabel!
    @IBOutlet weak var createAtValue: UILabel!
    // Three native tabs
    @IBOutlet var taps: [UIButton]!
    @IBOutlet weak var commentsButton: UIButton!
    @IBOutlet weak var followingButton: UIButton!
    @IBOutlet weak var followersButton: UIButton!
    @IBOutlet weak var selectionIndicatorView: UIView!
    @IBOutlet weak var selectionIndicatorConstraint: NSLayoutConstraint!
    
    //MARK: - Properties
    private var viewModel: RepoDescriptionViewModel?
    private let tapsTitle = ["Comments", "Following", "Followers"]
    lazy var tapsSelectionType: [Bool] = [viewModel?.pageType.value == .comments, viewModel?.pageType.value == .following, viewModel?.pageType.value == .followers]
    private let icons = [ImagesDesignSystem.images.privateIcon.image, ImagesDesignSystem.images.forkIcon.image,  ImagesDesignSystem.images.repoTypeIcon.image, ImagesDesignSystem.images.locationIcon.image, ImagesDesignSystem.images.gitHubIcon.image]

    
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
        //bodySetup
        ownerName.config(font: UIFont(name: AppFonts.regularHelvetica, size: 13) ?? UIFont(), color: ColorDesignSystem.Colors.black.color)
        ownerUserName.config(font: UIFont(name: AppFonts.regularHelvetica, size: 11) ?? UIFont(), color: ColorDesignSystem.Colors.gray.color)
        repoName.config(font: UIFont(name: AppFonts.boldHelvetica, size: 18) ?? UIFont(), color: ColorDesignSystem.Colors.black.color)
        privateTitle.config(font: UIFont(name: AppFonts.regularHelvetica, size: 12) ?? UIFont(), color: ColorDesignSystem.Colors.gray.color)
        forkTitle.config(font: UIFont(name: AppFonts.regularHelvetica, size: 12) ?? UIFont(), color: ColorDesignSystem.Colors.gray.color)
        repoOwnerTitle.config(font: UIFont(name: AppFonts.regularHelvetica, size: 12) ?? UIFont(), color: ColorDesignSystem.Colors.gray.color)
        repoDescription.config(font: UIFont(name: AppFonts.regularHelvetica, size: 12) ?? UIFont(), color: ColorDesignSystem.Colors.inputDarkerGray.color, numberOfLines: 0)
        repoLink.config(font: UIFont(name: AppFonts.regularHelvetica, size: 12) ?? UIFont(), color: ColorDesignSystem.Colors.linkBlue.color)
        locationTitle.config(font: UIFont(name: AppFonts.regularHelvetica, size: 12) ?? UIFont(), color: ColorDesignSystem.Colors.gray.color)
        createAtTitle.config(font: UIFont(name: AppFonts.regularHelvetica, size: 12) ?? UIFont(), color: ColorDesignSystem.Colors.black.color, text: "Created at:")
        createAtValue.config(font: UIFont(name: AppFonts.regularHelvetica, size: 11) ?? UIFont(), color: ColorDesignSystem.Colors.inputDarkerGray.color)
        gitHubLinkStack.isUserInteractionEnabled = true
        //Header Icons Setup
        for (image, icon) in zip(headerIcons, icons) { image.image = icon }
        // Three tabs setup
        for (button, (title, selection)) in zip(taps, zip(tapsTitle, tapsSelectionType))  {
            button.config(font: UIFont(name: AppFonts.regularHelvetica, size: 15) ?? UIFont(), color: ColorDesignSystem.Colors.gray.color, text: title)
            button.setTitleColor(ColorDesignSystem.Colors.appRed.color, for: .selected)
            button.isSelected = selection
            button.tintColor = .clear
        }
        selectionIndicatorView.backgroundColor = ColorDesignSystem.Colors.appRed.color
    }
    
    private func setupRepositoriesTable() {
        repoDescriptionTableView.backgroundColor = .clear
        repoDescriptionTableView.separatorStyle = .none
        repoDescriptionTableView.showsVerticalScrollIndicator = false
        repoDescriptionTableView.showsHorizontalScrollIndicator = false
        repoDescriptionTableView.isHidden = true
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
