//
//  RepositoryNetworking.swift
//  RobustaStudioTask
//
//  Created by ahmed moharam on 10/09/2021.
//
import Foundation
import Combine

enum PurchaseServiceEndpoints {
    case repositoriesList
    case userData(userUrl: String)
    case commentsList(loginKey: String)
    case followersList(url: String)
    case followingList(loginKey: String)
}

extension PurchaseServiceEndpoints {
    
    // specify the type of HTTP request
    var httpMethod: HTTPMethod {
        return .GET
    }
    
    // encodable request body for POST
    var requestBody: Encodable? {
        return nil
    }
    
    // compose urls for each request
    var getURL: String {
        switch self {
        case .repositoriesList:
            return environment.purchaseServiceBaseUrl + "/repositories"
        case let .userData(userUrl):
            return "\(userUrl)"
        case let .commentsList(loginKey):
            return environment.purchaseServiceBaseUrl + "/repos/\(loginKey)/comments"
        case let .followersList(url):
            return "\(url)"
        case let .followingList(loginKey):
            return  environment.purchaseServiceBaseUrl + "/users/\(loginKey)/following"
        }
    }
    
    // app environment
    var environment: Environment {
        return .development
    }
    
    // compose the NetworkRequest
    func createRequest() -> NetworkRequest {
        print("final url",  getURL)
        return NetworkRequest(url: getURL, headers: [:], reqBody: requestBody, httpMethod: httpMethod)
    }
}
