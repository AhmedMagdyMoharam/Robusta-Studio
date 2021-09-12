//
//  GitHubRepositoriesViewModel.swift
//  RobustaStudioTask
//
//  Created by ahmed moharam on 10/09/2021.
//

import Foundation
import Combine

//MARK: - GitHubRepositoriesViewModelProtocol
protocol GitHubRepositoriesViewModelProtocol {
    var state: PassthroughSubject<GitHubRepositoriesViewModel.PageState, Never> { get }
    var reposList: CurrentValueSubject<[RepositoryVMProtocol], Never> { get }
    var searchValue: CurrentValueSubject<String,Never> { get }
    func LoadRepositoriesList()
    func loadRepoDataIfNeeded(shouldClear: Bool)
}

class GitHubRepositoriesViewModel: GitHubRepositoriesViewModelProtocol {
    
    // MARK: - Enums
    enum PageState {
        case loading(_ show: Bool)
        case showMessage(message: String, state: ToastManager.ToastStatus)
        case zeroState(show: Bool)
    }
    
    // MARK: - Properties
    private var subscriptions = Set<AnyCancellable>()
    private var page = 1
    private var pageLimit = 10 // pagination limit 10 Row in page
    private var provider: RepositoryProviderProtocol?
    private var parentBulkReposList: [RepositoryVMProtocol] = [] // parent bulk data
    private var filteredListData: [RepositoryVMProtocol] = []
    private var splitReposLists: [[RepositoryVMProtocol]] = [] //split array of data to pages by limit 10
    var reposList = CurrentValueSubject<[RepositoryVMProtocol], Never>([]) // final repo list
    var searchValue = CurrentValueSubject<String, Never>("") // search input value
    var state = PassthroughSubject<PageState, Never>()
    private lazy var requestCompletionHandler: (Subscribers.Completion<NetworkError>) -> Void = { [weak self] completion in
        guard let self = self else { return }
        self.state.send(.loading(false))
        switch completion {
        case let .failure(error):
            self.state.send(.showMessage(message: Message.poorConnection, state: .failure))
        case .finished:
            print("Api Finished")
        }
    }
    
    // MARK: - Init
    init(provider: RepositoryProviderProtocol) {
        self.provider = provider
        bindings()
    }
    
    //MARK: - Methods
    func loadRepoDataIfNeeded(shouldClear: Bool) {
        if shouldClear { page = 1 }
        !self.searchValue.value.isEmpty ? localSearch() : (filteredListData = parentBulkReposList)
        splitReposLists = filteredListData.chunked(by: self.pageLimit)
        
        if splitReposLists.count >= page {
            print("Page is:", page)
            let newPageData = splitReposLists[page - 1]
            self.state.send(.zeroState(show: false))
            shouldClear ? (reposList.value = newPageData) : (reposList.value += newPageData)
            page += 1
        } else if splitReposLists.isEmpty {
            reposList.value.removeAll()
            state.send(.zeroState(show: true))
        }
    }
    
    // Local Search
    private func localSearch() {
        filteredListData = parentBulkReposList.filter({ $0.name?.lowercased().contains(searchValue.value.lowercased()) ?? false})
    }
    
    private func bindings() {
        searchValue
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.loadRepoDataIfNeeded(shouldClear: true)
            }.store(in: &subscriptions)
    }
    
    //MARK: API Call
    func LoadRepositoriesList() { // repos Api
        self.state.send(.loading(true))
        let responseHandler: (([RepositoryModel]) -> Void) = { [weak self] response in
            guard let self = self else { return }
            self.parentBulkReposList = (response).map {RepositoryVM(repo: $0) }
            self.filteredListData = self.parentBulkReposList
            self.loadRepoDataIfNeeded(shouldClear: true)
        }
        
        provider?.repositoriesList()
            .sink(receiveCompletion: requestCompletionHandler, receiveValue: responseHandler)
            .store(in: &subscriptions)
    }
}
