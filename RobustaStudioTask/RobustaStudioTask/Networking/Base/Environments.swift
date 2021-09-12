//
//  AppEnvironment.swift
//  RobustaStudioTask
//
//  Created by ahmed moharam on 10/09/2021.
//

import Foundation

// MARK: - App Environments
enum Environment: String, CaseIterable {
    case development
}

extension Environment {
    
    //MARK: - Properties
    var purchaseServiceBaseUrl: String {
        switch self {
        case .development:
            return Server.developmentBaseURL
        }
    }
}
