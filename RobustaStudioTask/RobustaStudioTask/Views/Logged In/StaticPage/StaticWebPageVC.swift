//
//  StaticPagesVC.swift
//  RobustaStudioTask
//
//  Created by ahmed moharam on 11/09/2021.
//

import Foundation
import UIKit
import WebKit

class StaticWebPageVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var staticWebView: WKWebView!
    
    //MARK:- Properties
    private var url: String?
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Init & dealloc methods
    deinit {
        print("Static Pages VC De init success")
    }
    
    //MARK:- Methods
    /// Dependency injection of StaticPagesVC
    class func create(url: String) -> StaticWebPageVC {
        let vc: StaticWebPageVC = StoryBoardDesignSystem.StoryBoard.repoDescription.name.instantiateViewController(identifier: "\(StaticWebPageVC.self)")
        vc.url = url
        return vc
    }
    
    private func setupUI() {
        self.title = "GitHub"
        staticWebView.backgroundColor = .clear
        if let url = URL(string: url ?? "") {
            staticWebView.load(URLRequest(url: url))
        }
    }
}
