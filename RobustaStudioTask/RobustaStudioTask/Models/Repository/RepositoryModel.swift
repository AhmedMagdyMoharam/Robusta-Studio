//
//  RepositoryModel.swift
//  RobustaStudioTask
//
//  Created by ahmed moharam on 10/09/2021.
//

import Foundation

//MARK: - RepositoryModel
class RepositoryModel: Codable {
    let name, topicDescription, commentsURL, languagesURL, fullRepoName, url: String?
    let topicPrivate, fork: Bool?
    let owner: UserModel?
    
    enum CodingKeys: String, CodingKey {
        case name, owner ,fork, url
        case topicPrivate = "private"
        case fullRepoName = "full_name"
        case topicDescription = "description"
        case languagesURL = "languages_url"
        case commentsURL = "comments_url"
    }
}

// MARK: - OwnerModel
class UserModel: Codable {
    let login, avatarURL ,htmlURL ,followingURL, type, followersURL, name, company, createdAt, location, url: String?
    let siteAdmin: Bool?
    
    enum CodingKeys: String, CodingKey {
        case login, type, name, company, url, location
        case avatarURL = "avatar_url"
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case createdAt = "created_at"
        case siteAdmin = "site_admin"
    }
}
