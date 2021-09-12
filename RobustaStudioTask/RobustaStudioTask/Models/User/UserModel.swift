//
//  UserModel.swift
//  RobustaStudioTask
//
//  Created by ahmed moharam on 12/09/2021.
//

import Foundation

// MARK: - OwnerModel
class UserModel: Codable {
    
    let login, avatarURL ,htmlURL ,followingURL, type, followersURL, name, company, createdAt, location, url, commentsURL: String?
    let siteAdmin: Bool?
    
    enum CodingKeys: String, CodingKey {
        case login, type, name, company, url, location
        case commentsURL = "comments_url"
        case avatarURL = "avatar_url"
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case createdAt = "created_at"
        case siteAdmin = "site_admin"
    }
}
