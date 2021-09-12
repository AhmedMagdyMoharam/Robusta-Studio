//
//  RepoDescriptionViewModel.swift
//  RobustaStudioTask
//
//  Created by ahmed moharam on 11/09/2021.
//

import Foundation
import Combine

protocol RepoDescriptionViewModelProtocol {
    var state: PassthroughSubject<RepoDescriptionViewModel.PageState, Never> { get }
    var pageType: CurrentValueSubject<RepoDescriptionViewModel.pageType, Never> { get }
    var repoData: RepositoryVMProtocol? { get }
    var followsList: CurrentValueSubject<[UserVMProtocol], Never> { get }
    var commentsList: CurrentValueSubject<[CommentVMProtocol], Never> { get }
    var userData: CurrentValueSubject<UserVMProtocol?, Never> { get }
    func handlingZeroState() -> String
    func loadUserData()
    func loadFollowersList()
}

class RepoDescriptionViewModel: RepoDescriptionViewModelProtocol {
    
    // MARK: - Enums
    enum PageState {
        case loading(_ show: Bool)
        case showError(message: String)
        case showZeroState(show: Bool)
    }
    enum pageType {
        case comments
        case following
        case followers
    }
    
    // MARK: - Properties
    private var subscriptions = Set<AnyCancellable>()
    private var provider: RepositoryProviderProtocol?
    var repoData: RepositoryVMProtocol?
    var userData = CurrentValueSubject<UserVMProtocol?, Never>(nil)
    var followsList = CurrentValueSubject<[UserVMProtocol], Never>([])
    var commentsList = CurrentValueSubject<[CommentVMProtocol], Never>([])
    var pageType = CurrentValueSubject<pageType, Never>(.comments)
    var state = PassthroughSubject<PageState, Never>()
    private lazy var requestCompletionHandler: (Subscribers.Completion<NetworkError>) -> Void = { [weak self] completion in
        self?.state.send(.loading(false))
        switch completion {
        case .failure(let error):
            print(error)
            self?.state.send(.showError(message: Message.poorConnection))
        case .finished:
            print("Finished")
        }
    }
    
    // MARK: - Init
    init(provider: RepositoryProviderProtocol, repoData: RepositoryVMProtocol?, pageType: pageType) {
        self.provider = provider
        self.repoData = repoData
        self.pageType.value = pageType
    }
    
    //MARK: - Methods
    func handlingZeroState() -> String {
        switch self.pageType.value {
        case .comments:
            return "No comments yet!"
        case .following:
            return "No following yet!"
        case .followers:
            return "No followers yet!"
        }
    }
    
    private func clearAllData() {
        commentsList.value.removeAll()
        followsList.value.removeAll()
    }
    
    //MARK: API Call
    func loadUserData() {
        let responseHandler: ((UserModel) -> Void) = { [weak self] response in
            guard let self = self else { return }
            self.userData.value = UserVM(user: response)
            self.loadFollowersList()
        }
        state.send(.loading(true))
        provider?.userData(userUrl: repoData?.owner?.userURL ?? "")
            .sink(receiveCompletion: requestCompletionHandler, receiveValue: responseHandler)
            .store(in: &subscriptions)
    }
        
    func loadFollowersList() {
        let commentsResponseHandler: (([CommentModel]) -> Void) = { [weak self] response in
            guard let self = self else { return }
            response.count == 0 ? (self.state.send(.showZeroState(show: true))) : (self.state.send(.showZeroState(show: false)))
            self.commentsList.value = response.map { CommentVM(comment: $0) }
        }
        
        let followResponseHandler: (([UserModel]) -> Void) = { [weak self] response in
            guard let self = self else { return }
            response.count == 0 ? (self.state.send(.showZeroState(show: true))) : (self.state.send(.showZeroState(show: false)))
            self.followsList.value = response.map { UserVM(user: $0) }
        }
        
        state.send(.loading(true))
        clearAllData()
        
        switch self.pageType.value {
        case .comments: // Comments Api
            provider?.commentsList(loginKey: repoData?.fullRepoName ?? "")
                .sink(receiveCompletion: requestCompletionHandler, receiveValue: commentsResponseHandler)
                .store(in: &subscriptions)
        case .following: // Following Api
            provider?.followingList(loginKey: repoData?.owner?.ownerUserName ?? "")
                .sink(receiveCompletion: requestCompletionHandler, receiveValue: followResponseHandler)
                .store(in: &subscriptions)
        case .followers: //Followers Api
            provider?.followersList(url: repoData?.owner?.followersURL ?? "")
                .sink(receiveCompletion: requestCompletionHandler, receiveValue: followResponseHandler)
                .store(in: &subscriptions)
        }
    }
}
