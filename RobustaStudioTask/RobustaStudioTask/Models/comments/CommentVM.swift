//
//  CommentsVM.swift
//  RobustaStudioTask
//
//  Created by ahmed moharam on 12/09/2021.
//

import Foundation

protocol CommentVMProtocol {
    var createdAt: String? { get }
    var body: String? { get }
    var authorAssociation: String? { get }
    var user: UserVMProtocol? { get }
}

class CommentVM: CommentVMProtocol {
    
    //MARK: - Proberties
    let comment: CommentModel?
    
    //MARK: - Init
    init(comment: CommentModel?) {
        self.comment = comment
    }
    
    var createdAt: String? {
        guard let date = comment?.createdAt else { return nil }
        let finalDate = date.toDate()
        if comment?.createdAt?.monthsBetween() ?? 0 > 6 {
            return finalDate?.timeAgo()
        }
        return finalDate?.toString(withFormat: .lessThanSixMonths)
    }
    var body: String? {
        comment?.body
    }
    var authorAssociation: String? {
        comment?.authorAssociation
    }
    var user: UserVMProtocol? {
        UserVM(user: comment?.user)
    }
}
