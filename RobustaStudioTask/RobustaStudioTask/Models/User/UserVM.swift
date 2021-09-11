//
//  UserVM.swift
//  RobustaStudioTask
//
//  Created by ahmed moharam on 12/09/2021.
//

import Foundation

//MARK: - OwnerVMProtocol
protocol UserVMProtocol {
    var name: String? { get }
    var location: String? { get }
    var userURL: String? { get }
    var company: String? { get }
    var createdAt: String? { get }
    var ownerUserName: String? { get}
    var avatarURL: String? { get}
    var followingURL: String? { get}
    var commentsURL: String? { get }
    var followersURL: String? { get}
    var typeType: OwnerType? { get}
    var gitHubRepoLink: String? { get }
    var siteAdmin: Bool? { get}
}

class UserVM: UserVMProtocol {
    
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
    var commentsURL: String? {
        user?.commentsURL
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
