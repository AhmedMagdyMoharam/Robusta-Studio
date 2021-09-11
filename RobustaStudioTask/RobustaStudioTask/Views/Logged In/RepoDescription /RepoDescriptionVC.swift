//
//  RepoDescriptionVC.swift
//  RobustaStudioTask
//
//  Created by ahmed moharam on 11/09/2021.
//

import Foundation
import Combine
import UIKit

class RepoDescriptionVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet var mainView:  RepoDescriptionView!
    
    //MARK: - Properties
    private var viewModel: RepoDescriptionViewModelProtocol?
    private var shownIndexes: [IndexPath] = [] // used for cells animation
    private var subscriptions = Set<AnyCancellable>()
    
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
    class func create(viewModel: RepoDescriptionViewModelProtocol) -> RepoDescriptionVC {
        let vc: RepoDescriptionVC = StoryBoardDesignSystem.StoryBoard.repoDescription.name.instantiateViewController(identifier: "\(RepoDescriptionVC.self)")
        vc.viewModel = viewModel
        return vc
    }
    
    private func setup() {
        guard let viewModel = viewModel else { return }
        title = "Repo Description"
        viewModel.loadUserData()
        setupBindings()
    }
    
    private func setupBindings() {
        guard let viewModel = viewModel else { return }
        mainView.commentsButton.publisher(for: .touchUpInside)
            .receive(on: DispatchQueue.main)
            .sink { _ in
                viewModel.pageType.value = .comments
            }.store(in: &subscriptions)
        
        mainView.followingButton.publisher(for: .touchUpInside)
            .receive(on: DispatchQueue.main)
            .sink { _ in
                viewModel.pageType.value = .following
            }.store(in: &subscriptions)
        
        mainView.followersButton.publisher(for: .touchUpInside)
            .receive(on: DispatchQueue.main)
            .sink { _ in
                viewModel.pageType.value = .followers
            }.store(in: &subscriptions)
        
        mainView.gitHubLinkStack.tapGesture()
            .receive(on: DispatchQueue.main)
            .sink { [ weak self ] _ in
                guard let self = self else { return }
                let vc = StaticPagesVC.create(url: viewModel.userData.value?.gitHubRepoLink ?? "")
                self.navigationController?.pushViewController(vc, animated: true)
            }.store(in: &subscriptions)
        
        viewModel.userData
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .sink { [ weak self ] user in
                guard let self = self, let repoData = viewModel.repoData, let userData = user else { return }
                self.mainView.fetchRepoData(repoData: repoData, user: userData)
            }.store(in: &subscriptions)
        
        viewModel.pageType
            .receive(on: DispatchQueue.main)
            .sink { [weak self] dataSource in
                guard let self = self else { return }
                self.mainView.updateTabsUI(for: dataSource)
            }.store(in: &subscriptions)
        
        viewModel.state
            .receive(on: DispatchQueue.main)
            .sink {
                switch $0 {
                case let .loading(show):
                    show ? LoadingSpinnerManager.shared.showGeneral() : LoadingSpinnerManager.shared.hide()
                case let .showError(message):
                    ToastManager.shared.showError(message: message, status: .failure)
                }
            }.store(in: &subscriptions)
    }
}

//MARK: - TableView Configurations
extension RepoDescriptionVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(RepositoryCell.self)") as? RepositoryCell else { return UITableViewCell() }
//        cell.data = reposList[exist: indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Cell Animation
        if !shownIndexes.contains(indexPath) {
            AnimationUtility.shared.animate(cell)
            shownIndexes.append(indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
