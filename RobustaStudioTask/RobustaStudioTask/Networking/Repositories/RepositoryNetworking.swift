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
            return "/repositories"
        }
    }
    
    // app environment
    var environment: Environment {
        return .development
    }
    
    // compose the NetworkRequest
    func createRequest() -> NetworkRequest {
        return NetworkRequest(url: environment.purchaseServiceBaseUrl + getURL, headers: [:], reqBody: requestBody, httpMethod: httpMethod)
    }
}
