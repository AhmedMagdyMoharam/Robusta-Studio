//
//  StoryBoardDesignSystem.swift
//  RobustaStudioTask
//
//  Created by ahmed moharam on 10/09/2021.
//

import UIKit

/// I usually use Swift Gen
struct StoryBoardDesignSystem {
    
    enum StoryBoard: String {
        case main = "Main"
        case home = "Home"
        
        var name: UIStoryboard {
            return UIStoryboard(name: self.rawValue, bundle: .none)
        }
    }
}
