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
    func LoadRepositoriesList()
}

class RepositoriesListViewModel: RepositoriesListViewModelProtocol {
    
    // MARK: - Enums
    enum PageState {
        case loading(_ show: Bool)
        case showMessage(message: String, state: ToastManager.ToastStatus)
    }
    
    // MARK: - Properties
    private var subscriptions = Set<AnyCancellable>()
    private var provider: RepositoryProviderProtocol?
    private var repositoriesList: [RepositoryVMProtocol]?
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
    func LoadRepositoriesList() {
        self.state.send(.loading(true))
        
        let responseHandler: (([RepositoryModel]) -> Void) = { [weak self] response in
            guard let self = self else { return }
            self.repositoriesList = (response).map {RepositoryVM(repo: $0) }
        }
        
        provider?.repositoriesList()
            .sink(receiveCompletion: requestCompletionHandler, receiveValue: responseHandler)
            .store(in: &subscriptions)
    }
}
