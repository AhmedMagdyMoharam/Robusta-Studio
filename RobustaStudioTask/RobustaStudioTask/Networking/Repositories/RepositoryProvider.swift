//
//  RepositoryProvider.swift
//  RobustaStudioTask
//
//  Created by ahmed moharam on 10/09/2021.
//
import Foundation
import Combine

protocol RepositoryProviderProtocol {
    func repositoriesList() -> AnyPublisher<[RepositoryModel], NetworkError>
}

class RepositoryProvider: RepositoryProviderProtocol {
    
    private var networkRequest: RequitableProtocol
    
    init(networkRequest: RequitableProtocol) {
        self.networkRequest = networkRequest
    }

    func repositoriesList() -> AnyPublisher<[RepositoryModel], NetworkError> {
        return self.networkRequest.request(PurchaseServiceEndpoints.repositoriesList.createRequest())
    }
  
}
