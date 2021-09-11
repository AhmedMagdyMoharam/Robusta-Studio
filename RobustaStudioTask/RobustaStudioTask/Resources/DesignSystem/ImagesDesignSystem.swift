//
//  ImagesDesignSystem.swift
//  RobustaStudioTask
//
//  Created by ahmed moharam on 10/09/2021.
//

import UIKit

/// I usually use Swift Gen (fonts, images, storyboards)
struct ImagesDesignSystem {
    
    enum images: String {
        //Landing Page
        case loadingPagePlaceHolder = "LoadingPlaceHolder"
        case zeroStateRepos = "ZeroStateRepos"
        case repoTypeIcon = "RepoTypeIcon"
        case userPlaceHolder = "UserPlaceHolder"
        case repoIcon = "RepoIcon"
        case gitHubIcon = "GitHubIcon"
        case forkIcon = "Fork"
        case privateIcon = "Private"
        case publicIcon = "Public"
        case back = "Back"
        case homeHeaderImage = "HomeHeaderImage"
        case locationIcon = "LocationIcon"
        
        var image: UIImage {
            return UIImage(named: self.rawValue) ?? UIImage()
        }
    }
}


