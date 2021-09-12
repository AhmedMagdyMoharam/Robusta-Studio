//
//  CommentsModel.swift
//  RobustaStudioTask
//
//  Created by ahmed moharam on 12/09/2021.
//

import Foundation

//MARK: - RepositoryModel
class CommentModel: Codable {
    var createdAt, body: String?
    var user: UserModel?
    
    init() {}
    
    enum CodingKeys: String, CodingKey {
        case user, body
        case createdAt = "created_at"
    }
}
