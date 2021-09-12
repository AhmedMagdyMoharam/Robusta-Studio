//
//  StoryBoardDesignSystem.swift
//  RobustaStudioTask
//
//  Created by ahmed moharam on 10/09/2021.
//

import UIKit

/// I usually use Swift Gen (fonts, images, storyboards)
struct StoryBoardDesignSystem {
    
    enum StoryBoard: String {
        case main = "Loading"
        case home = "Repos"
        case repoDescription = "RepoDetails"
        
        var name: UIStoryboard {
            return UIStoryboard(name: self.rawValue, bundle: .none)
        }
    }
}
