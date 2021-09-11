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

protocol RepositoryVMProtocol {
    var id: Int? { get }
    var name: String? { get }
    var topicPrivate: Bool? { get }
    var owner: OwnerVMProtocol? { get }
    var topicDescription: String? { get }
    var fork: Bool? { get }
}

class RepositoryVM: RepositoryVMProtocol {
    
    //MARK: - Proberties
    let repo: RepositoryModel
    
    //MARK: - Init
    init(repo: RepositoryModel) {
        self.repo = repo
    }
    
    var id: Int? {
        repo.id
    }
    var name: String? {
        repo.name
    }
    var topicPrivate: Bool? {
        repo.topicPrivate
    }
    var owner: OwnerVMProtocol? {
        OwnerVM(owner: repo.owner)
    }
    var topicDescription: String? {
        repo.topicDescription
    }
    var fork: Bool? {
        repo.fork
    }
}


protocol OwnerVMProtocol {
    var ownerName: String? { get}
    var id: Int? { get}
    var avatarURL: String? { get}
    var followingURL: String? { get}
    var followersURL: String? { get}
    var type: OwnerType? { get}
    var siteAdmin: Bool? { get}
}

class OwnerVM: OwnerVMProtocol {
    
    //MARK: - Proberties
    let owner: OwnerModel?
    
    //MARK: - Init
    init(owner: OwnerModel?) {
        self.owner = owner
    }
    
    var ownerName: String? {
        owner?.login
    }
    var id: Int? {
        owner?.id
    }
    var avatarURL: String? {
        owner?.avatarURL
    }
    var followingURL: String? {
        owner?.followingURL
    }
    var followersURL: String? {
        owner?.followersURL
    }
    var type: OwnerType? {
        OwnerType(rawValue: owner?.type ?? "")
    }
    var siteAdmin: Bool? {
        owner?.siteAdmin
    }
}
