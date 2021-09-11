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
    var userData: CurrentValueSubject<OwnerVMProtocol?, Never> { get }
    func loadUserData()
}

class RepoDescriptionViewModel: RepoDescriptionViewModelProtocol {
    
    // MARK: - Enums
    enum PageState {
        case loading(_ show: Bool)
        case showError(message: String)
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
    var userData = CurrentValueSubject<OwnerVMProtocol?, Never>(nil)
    var pageType = CurrentValueSubject<pageType, Never>(.comments)
    var state = PassthroughSubject<PageState, Never>()
    private lazy var requestCompletionHandler: (Subscribers.Completion<NetworkError>) -> Void = { [weak self] completion in
        self?.state.send(.loading(false))
        switch completion {
        case .failure(let error):
            print(error)
            self?.state.send(.showError(message: error.localizedDescription))
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
    func loadUserData() {
        let responseHandler: ((UserModel) -> Void) = { [weak self] response in
            guard let self = self else { return }
            self.userData.value = OwnerVM(user: response)
        }
        state.send(.loading(true))
        provider?.userData(userUrl: repoData?.owner?.userURL ?? "")
            .sink(receiveCompletion: requestCompletionHandler, receiveValue: responseHandler)
            .store(in: &subscriptions)
    }
}
