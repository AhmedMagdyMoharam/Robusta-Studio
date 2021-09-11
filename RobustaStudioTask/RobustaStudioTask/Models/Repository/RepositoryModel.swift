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
