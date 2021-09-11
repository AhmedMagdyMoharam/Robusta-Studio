//
//  ImagesDesignSystem.swift
//  RobustaStudioTask
//
//  Created by ahmed moharam on 10/09/2021.
//

import UIKit

/// I usually use Swift Gen
struct ImagesDesignSystem {
    
    enum backGroundImage: String {
        //Landing Page
        case loadingPagePlaceHolder = "LoadingPlaceHolder"
        case zeroStateRepos = "ZeroStateRepos"
        case repoTypeIcon = "RepoTypeIcon"
        case userPlaceHolder = "UserPlaceHolder"
        case repoIcon = "RepoIcon"
        
        var image: UIImage {
            return UIImage(named: self.rawValue) ?? UIImage()
        }
    }
}


