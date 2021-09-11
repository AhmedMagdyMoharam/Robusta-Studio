//
//  RepositoryVM.swift
//  RobustaStudioTask
//
//  Created by ahmed moharam on 10/09/2021.
//

import Foundation

enum OwnerType: String {
    case user = "User"
    case organization = "Organization"
}

protocol RepositoryVMProtocol {
    var id: Int? { get }
    var nodeID: String? { get }
    var name: String? { get }
    var fullName: String? { get }
    var topicPrivate: Bool? { get }
    var owner: OwnerVMProtocol? { get }
    var htmlURL: String? { get }
    var topicDescription: String? { get }
    var fork: Bool? { get }
    var url: String? { get }
    var forksURL: String? { get }
    var keysURL: String? { get }
    var teamsURL: String? { get }
    var issueEventsURL: String? { get }
    var eventsURL: String? { get }
    var assigneesURL: String? { get }
    var tagsURL: String? { get }
    var blobsURL: String? { get }
    var collaboratorsURL: String? { get }
    var hooksURL: String? { get }
    var branchesURL: String? { get }
    var gitTagsURL: String? { get }
    var gitRefsURL: String? { get }
    var treesURL: String? { get }
    var statusesURL: String? { get }
    var languagesURL: String? { get }
    var subscriptionURL: String? { get }
    var commitsURL: String? { get }
    var stargazersURL: String? { get }
    var contributorsURL: String? { get }
    var subscribersURL: String? { get }
    var gitCommitsURL: String? { get }
    var commentsURL: String? { get }
    var issueCommentURL: String? { get }
    var compareURL: String? { get }
    var contentsURL: String? { get }
    var mergesURL: String? { get }
    var archiveURL: String? { get }
    var downloadsURL: String? { get }
    var issuesURL: String? { get }
    var pullsURL: String? { get }
    var milestonesURL: String? { get }
    var notificationsURL: String? { get }
    var releasesURL: String? { get }
    var labelsURL: String? { get }
    var deploymentsURL: String? { get }
}

class RepositoryVM: RepositoryVMProtocol {
    
    //MARK: - Proberties
    let repo: RepositoryModel
    
    //MARK: - Init
    init(repo: RepositoryModel) {
        self.repo = repo
    }
    
    var id: Int?{
        repo.id
    }
    var nodeID: String?{
        repo.nodeID
    }
    var name: String?{
        repo.name
    }
    var fullName: String?{
        repo.fullName
    }
    var topicPrivate: Bool?{
        repo.topicPrivate
    }
    var owner: OwnerVMProtocol?{
        OwnerVM(owner: repo.owner)
    }
    var htmlURL: String?{
        repo.htmlURL
    }
    var topicDescription: String?{
        repo.topicDescription
    }
    var fork: Bool?{
        repo.fork
    }
    var url: String?{
        repo.url
    }
    var forksURL: String?{
        repo.forksURL
    }
    var keysURL: String?{
        repo.keysURL
    }
    var teamsURL: String?{
        repo.teamsURL
    }
    var issueEventsURL: String?{
        repo.issueEventsURL
    }
    var eventsURL: String?{
        repo.eventsURL
    }
    var assigneesURL: String?{
        repo.assigneesURL
    }
    var tagsURL: String?{
        repo.tagsURL
    }
    var blobsURL: String?{
        repo.blobsURL
    }
    var collaboratorsURL: String?{
        repo.collaboratorsURL
    }
    var hooksURL: String?{
        repo.hooksURL
    }
    var branchesURL: String?{
        repo.branchesURL
    }
    var gitTagsURL: String?{
        repo.gitTagsURL
    }
    var gitRefsURL: String?{
        repo.gitRefsURL
    }
    var treesURL: String?{
        repo.treesURL
    }
    var statusesURL: String?{
        repo.statusesURL
    }
    var languagesURL: String?{
        repo.languagesURL
    }
    var subscriptionURL: String?{
        repo.subscriptionURL
    }
    var commitsURL: String?{
        repo.commitsURL
    }
    var stargazersURL: String?{
        repo.stargazersURL
    }
    var contributorsURL: String?{
        repo.contributorsURL
    }
    var subscribersURL: String?{
        repo.subscribersURL
    }
    var gitCommitsURL: String?{
        repo.gitCommitsURL
    }
    var commentsURL: String?{
        repo.commentsURL
    }
    var issueCommentURL: String?{
        repo.issueCommentURL
    }
    var compareURL: String?{
        repo.compareURL
    }
    var contentsURL: String?{
        repo.contentsURL
    }
    var mergesURL: String?{
        repo.mergesURL
    }
    var archiveURL: String?{
        repo.archiveURL
    }
    var downloadsURL: String?{
        repo.downloadsURL
    }
    var issuesURL: String?{
        repo.issuesURL
    }
    var pullsURL: String?{
        repo.pullsURL
    }
    var milestonesURL: String?{
        repo.milestonesURL
    }
    var notificationsURL: String?{
        repo.notificationsURL
    }
    var releasesURL: String?{
        repo.releasesURL
    }
    var labelsURL: String?{
        repo.labelsURL
    }
    var deploymentsURL: String?{
        repo.deploymentsURL
    }
}


protocol OwnerVMProtocol {
    var ownerName: String? { get }
    var id: Int? { get }
    var nodeID: String? { get }
    var avatarURL: String? { get }
    var gravatarID: String? { get }
    var url: String? { get }
    var htmlURL: String? { get }
    var followingURL: String? { get }
    var followersURL: String? { get }
    var gistsURL: String? { get }
    var starredURL: String? { get }
    var organizationsURL: String? { get }
    var reposURL: String? { get }
    var subscriptionsURL: String? { get }
    var eventsURL: String? { get }
    var receivedEventsURL: String? { get }
    var type: OwnerType? { get }
    var siteAdmin: Bool? { get }
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
    var nodeID: String? {
        owner?.nodeID
    }
    var avatarURL: String? {
        owner?.avatarURL
    }
    var gravatarID: String? {
        owner?.gravatarID
    }
    var url: String? {
        owner?.url
    }
    var htmlURL: String? {
        owner?.htmlURL
    }
    var followingURL: String? {
        owner?.followingURL
    }
    var followersURL: String? {
        owner?.followersURL
    }
    var gistsURL: String? {
        owner?.gistsURL
    }
    var starredURL: String? {
        owner?.starredURL
    }
    var organizationsURL: String? {
        owner?.organizationsURL
    }
    var reposURL: String? {
        owner?.reposURL
    }
    var subscriptionsURL: String? {
        owner?.subscriptionsURL
    }
    var eventsURL: String? {
        owner?.eventsURL
    }
    var receivedEventsURL: String? {
        owner?.receivedEventsURL
    }
    var type: OwnerType? {
        OwnerType(rawValue: owner?.type ?? "")
    }
    var siteAdmin: Bool? {
        owner?.siteAdmin
    }
}
