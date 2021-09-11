//
//  RepositoryVM.swift
//  RobustaStudioTask
//
//  Created by ahmed moharam on 10/09/2021.
//

import Foundation

//MARK: - Enums
enum OwnerType: String {
    case user = "User"
    case organization = "Organization"
}

//MARK: - RepositoryVMProtocol
protocol RepositoryVMProtocol {
    var name: String? { get }
    var repoURL: String? { get }
    var fullRepoName: String? { get }
    var topicPrivate: String? { get }
    var owner: OwnerVMProtocol? { get }
    var topicDescription: String? { get }
    var fork: Bool? { get }
    var commentsURL: String? { get }
    var languageURL: String? { get }
}

class RepositoryVM: RepositoryVMProtocol {
    
    //MARK: - Proberties
    let repo: RepositoryModel
    
    //MARK: - Init
    init(repo: RepositoryModel) {
        self.repo = repo
    }
    
    var name: String? {
        repo.name
    }
    var repoURL: String? {
        repo.url
    }
    var fullRepoName: String? {
        repo.fullRepoName
    }
    var topicPrivate: String? {
        if repo.topicPrivate == true {
            return "Private"
        }
        return "Public"
    }
    var owner: OwnerVMProtocol? {
        OwnerVM(user: repo.owner)
    }
    var topicDescription: String? {
        repo.topicDescription
    }
    var fork: Bool? {
        repo.fork
    }
    var commentsURL: String? {
        repo.commentsURL
    }
    var languageURL: String? {
        repo.languagesURL
    }
}



//MARK: - OwnerVMProtocol
protocol OwnerVMProtocol {
    var name: String? { get }
    var location: String? { get }
    var userURL: String? { get }
    var company: String? { get }
    var createdAt: String? { get }
    var ownerUserName: String? { get}
    var avatarURL: String? { get}
    var followingURL: String? { get}
    var followersURL: String? { get}
    var typeType: OwnerType? { get}
    var gitHubRepoLink: String? { get }
    var siteAdmin: Bool? { get}
}

class OwnerVM: OwnerVMProtocol {
    
    //MARK: - Proberties
    let user: UserModel?
    
    //MARK: - Init
    init(user: UserModel?) {
        self.user = user
    }
    
    var location: String? {
        user?.location
    }
    var name: String? {
        user?.name
    }
    var userURL: String? {
        user?.url
    }
    var company: String? {
        user?.company
    }
    var createdAt: String? {
        guard let date = user?.createdAt else { return nil }
        let finalDate = date.toDate()
        if user?.createdAt?.monthsBetween() ?? 0 > 6 {
            return finalDate?.timeAgo()
        }
        return finalDate?.toString(withFormat: .lessThanSixMonths)
    }
    var ownerUserName: String? {
        user?.login
    }
    var avatarURL: String? {
        user?.avatarURL
    }
    var followingURL: String? {
        user?.followingURL
    }
    var followersURL: String? {
        user?.followersURL
    }
    var typeType: OwnerType? {
        OwnerType(rawValue: user?.type ?? "")
    }
    var gitHubRepoLink: String? {
        user?.htmlURL
    }
    var siteAdmin: Bool? {
        user?.siteAdmin
    }
}
