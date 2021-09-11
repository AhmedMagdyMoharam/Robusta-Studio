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
    var searchValue: CurrentValueSubject<String,Never> { get }
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
    private var page = 1
    private var pageLimit = 10 // pagination limit 10 Row in page
    private var provider: RepositoryProviderProtocol?
    private var parentBulkReposList: [RepositoryVMProtocol] = [] // parent bulk data
    private var localSearchList: [RepositoryVMProtocol] = []
    private var splitReposLists: [[RepositoryVMProtocol]] = [] //split array of data to pages by limit 10
    var reposList = CurrentValueSubject<[RepositoryVMProtocol], Never>([]) // final repo list
    var searchValue = CurrentValueSubject<String, Never>("") // search input value
    var state = PassthroughSubject<PageState, Never>()
    private lazy var requestCompletionHandler: (Subscribers.Completion<NetworkError>) -> Void = { [weak self] completion in
        guard let self = self else { return }
        self.state.send(.loading(false))
        switch completion {
        case let .failure(error):
            self.state.send(.showMessage(message: error.localizedDescription, state: .failure))
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
        
        !self.searchValue.value.isEmpty ? localSearch() : (localSearchList = parentBulkReposList)
        splitReposLists = localSearchList.chunked(by: self.pageLimit)
        
        if splitReposLists.count >= page {
            print("Page is:", page)
            let newPageData = splitReposLists[page - 1]
            page == 1 && newPageData.isEmpty == true ? (self.state.send(.zeroState(show: true))) : (self.state.send(.zeroState(show: false)))
            shouldClear ? (reposList.value = newPageData) : (reposList.value += newPageData)
            page += 1
        }
    }
    
    // Local Search
    private func localSearch() {
        self.localSearchList = self.parentBulkReposList.filter ({ userModel -> Bool in
            (userModel.name?.lowercased().contains(searchValue.value.lowercased()))!
        })
    }
    
    private func bindings() {
        searchValue
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.loadRepoDataIfNeeded(shouldClear: true)
            }.store(in: &subscriptions)
    }
    
    //MARK: API Call
    func LoadRepositoriesList() {
        self.state.send(.loading(true))
        let responseHandler: (([RepositoryModel]) -> Void) = { [weak self] response in
            guard let self = self else { return }
            self.parentBulkReposList = (response).map {RepositoryVM(repo: $0) }
            self.localSearchList = self.parentBulkReposList
            self.loadRepoDataIfNeeded(shouldClear: true)
        }
        
        provider?.repositoriesList()
            .sink(receiveCompletion: requestCompletionHandler, receiveValue: responseHandler)
            .store(in: &subscriptions)
    }
}
