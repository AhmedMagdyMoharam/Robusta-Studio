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
    func userData(userUrl: String) -> AnyPublisher<UserModel, NetworkError>
    func commentsList(loginKey: String) -> AnyPublisher<[CommentModel], NetworkError>
    func followersList(url: String) -> AnyPublisher<[UserModel], NetworkError>
    func followingList(loginKey: String) -> AnyPublisher<[UserModel], NetworkError>
}

class RepositoryProvider: RepositoryProviderProtocol {
    
    //MARK: - Properties
    private var networkRequest: RequitableProtocol
    
    //MARK: - Init
    init(networkRequest: RequitableProtocol) {
        self.networkRequest = networkRequest
    }

    //MARK: - Methods
    func repositoriesList() -> AnyPublisher<[RepositoryModel], NetworkError> {
        return self.networkRequest.request(PurchaseServiceEndpoints.repositoriesList.createRequest())
    }
    func userData(userUrl: String) -> AnyPublisher<UserModel, NetworkError> {
        return self.networkRequest.request(PurchaseServiceEndpoints.userData(userUrl: userUrl).createRequest())
    }
    func commentsList(loginKey: String) -> AnyPublisher<[CommentModel], NetworkError> {
        return self.networkRequest.request(PurchaseServiceEndpoints.commentsList(loginKey: loginKey).createRequest())
    }
    func followersList(url: String) -> AnyPublisher<[UserModel], NetworkError> {
        return self.networkRequest.request(PurchaseServiceEndpoints.followersList(url: url).createRequest())
    }
    func followingList(loginKey: String) -> AnyPublisher<[UserModel], NetworkError> {
        return self.networkRequest.request(PurchaseServiceEndpoints.followingList(loginKey: loginKey).createRequest())
    }
}
