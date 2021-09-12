//
//  RepositoryVM.swift
//  RobustaStudioTask
//
//  Created by ahmed moharam on 10/09/2021.
//

import Foundation

//MARK: - RepositoryVMProtocol
protocol RepositoryVMProtocol {
    var name: String? { get }
    var repoURL: String? { get }
    var fullRepoName: String? { get }
    var topicPrivate: String? { get }
    var owner: UserVMProtocol? { get }
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
    var owner: UserVMProtocol? {
        UserVM(user: repo.owner)
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

