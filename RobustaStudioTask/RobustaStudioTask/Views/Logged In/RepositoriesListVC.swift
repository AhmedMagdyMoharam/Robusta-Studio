//
//  RepositoriesListVC.swift
//  RobustaStudioTask
//
//  Created by ahmed moharam on 10/09/2021.
//

import Foundation
import UIKit
import Combine

class RepositoriesListVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet var mainView: RepositoriesListView!
    
    //MARK: - Properties
    private var subscriptions = Set<AnyCancellable>()
    private var viewModel: RepositoriesListViewModelProtocol?
    
    //MARK: - Init & dealloc methods
    deinit {
        print("DeInit called: \(String(describing: self))")
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    //MARK: - Methods
    class func create(viewModel: RepositoriesListViewModel) -> RepositoriesListVC {
        /// I usually use Swift Gen
        let vc: RepositoriesListVC = StoryBoardDesignSystem.StoryBoard.home.name.instantiateViewController(identifier: "\(RepositoriesListVC.self)")
        vc.viewModel = viewModel
        return vc
    }
    
    private func setup() {
        setupBindings()
    }
    
    private func setupBindings() {
        guard let viewModel = viewModel else { return }
        viewModel.state
            .sink {
                switch $0 {
                case let .loading(show):
                    show ? LoadingSpinnerManager.shared.showGeneral() : LoadingSpinnerManager.shared.hide()
                case let .showMessage(message, state):
                    ToastManager.shared.showError(message: message, status: state)
                }
            }.store(in: &subscriptions)
    }
}
