//
//  RepositoryModel.swift
//  RobustaStudioTask
//
//  Created by ahmed moharam on 10/09/2021.
//

import Foundation

//MARK: - RepositoryModel
class RepositoryModel: Codable {
    var name, topicDescription, commentsURL, languagesURL, fullRepoName, url: String?
    var topicPrivate, fork: Bool?
    var owner: UserModel?
    
    init() { }
    
    enum CodingKeys: String, CodingKey {
        case name, owner ,fork, url
        case topicPrivate = "private"
        case fullRepoName = "full_name"
        case topicDescription = "description"
        case languagesURL = "languages_url"
        case commentsURL = "comments_url"
    }
}
