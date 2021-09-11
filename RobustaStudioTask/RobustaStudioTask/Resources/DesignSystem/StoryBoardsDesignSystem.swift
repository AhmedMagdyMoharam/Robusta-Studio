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
        case main = "Main"
        case home = "Home"
        case repoDescription = "RepoDescription"
        
        var name: UIStoryboard {
            return UIStoryboard(name: self.rawValue, bundle: .none)
        }
    }
}
