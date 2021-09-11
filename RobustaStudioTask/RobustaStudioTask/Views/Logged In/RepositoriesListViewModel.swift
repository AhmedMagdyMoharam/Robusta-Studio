//
//  RepositoriesListViewModel.swift
//  RobustaStudioTask
//
//  Created by ahmed moharam on 10/09/2021.
//

import Foundation
import Combine

protocol RepositoriesListViewModelProtocol {
    var state: PassthroughSubject<RepositoriesListViewModel.PageState, Never> { get }
    var reposList: CurrentValueSubject<[RepositoryVMProtocol], Never> { get }
    func LoadRepositoriesList()
    func loadRepoDataIfNeeded(shouldClear: Bool)
}

class RepositoriesListViewModel: RepositoriesListViewModelProtocol {
    
    // MARK: - Enums
    enum PageState {
        case loading(_ show: Bool)
        case showMessage(message: String, state: ToastManager.ToastStatus)
        case zeroState(show: Bool)
    }
    
    // MARK: - Properties
    private var subscriptions = Set<AnyCancellable>()
    private var pageLimit = 10
    private var page = 1
    private var provider: RepositoryProviderProtocol?
    private var bulkedReposList: [RepositoryVMProtocol] = []
    private var splitReposLists: [[RepositoryVMProtocol]] = []
    var reposList = CurrentValueSubject<[RepositoryVMProtocol], Never>([])
    
    var state = PassthroughSubject<PageState, Never>()
    private lazy var requestCompletionHandler: (Subscribers.Completion<NetworkError>) -> Void = { [weak self] completion in
        guard let self = self else { return }
        self.state.send(.loading(false))
        switch completion {
        case let .failure(error):
            self.state.send(.showMessage(message: error.localizedDescription, state: .failure))
        case .finished:
            print("Finished")
        }
    }
    
    // MARK: - Init
    init(provider: RepositoryProviderProtocol) {
        self.provider = provider
    }
    
    //MARK: - Methods
    
    func loadRepoDataIfNeeded(shouldClear: Bool) {
        if splitReposLists.count >= page {
            let newPageData = splitReposLists[page - 1]
            if shouldClear { page = 1 }
            page == 1 && newPageData.isEmpty == true ? (self.state.send(.zeroState(show: true))) : (self.state.send(.zeroState(show: false)))
            shouldClear ? (reposList.value = newPageData) : (reposList.value += newPageData)
            page += 1
        }
    }

    //MARK: API Call
    func LoadRepositoriesList() {
        self.state.send(.loading(true))
        let responseHandler: (([RepositoryModel]) -> Void) = { [weak self] response in
            guard let self = self else { return }
            self.bulkedReposList = (response).map {RepositoryVM(repo: $0) }
            self.splitReposLists = self.bulkedReposList.chunked(by: self.pageLimit)
            self.loadRepoDataIfNeeded(shouldClear: true)
        }
        
        provider?.repositoriesList()
            .sink(receiveCompletion: requestCompletionHandler, receiveValue: responseHandler)
            .store(in: &subscriptions)
    }
}
