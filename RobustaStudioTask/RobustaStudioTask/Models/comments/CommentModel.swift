//
//  CommentsModel.swift
//  RobustaStudioTask
//
//  Created by ahmed moharam on 12/09/2021.
//

import Foundation

//MARK: - RepositoryModel
class CommentModel: Codable {
    let createdAt, body, authorAssociation: String?
    let user: UserModel?
    
    enum CodingKeys: String, CodingKey {
        case user, body
        case createdAt = "created_at"
        case authorAssociation = "author_association"
    }
}
