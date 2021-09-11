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
    private var shownIndexes: [IndexPath] = [] // used for cells animation
    private var refreshControl = UIRefreshControl()
    private var viewModel: RepositoriesListViewModelProtocol?
    private var repoList: [RepositoryVMProtocol] {
        viewModel?.reposList.value ?? []
    }
    
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
        guard let viewModel = viewModel else { return }
        setupBindings()
        pullToRefresh()
        viewModel.LoadRepositoriesList()
    }
    
    private func setupBindings() {
        guard let viewModel = viewModel else { return }
        
        viewModel.reposList
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [ weak self ] in
                guard let self = self, !$0.isEmpty else { return }
                self.mainView.repositoryTableView.reloadData()
            }.store(in: &subscriptions)
        
        viewModel.state
            .receive(on: DispatchQueue.main)
            .sink { [ weak self ] in
                guard let self = self else { return }
                switch $0 {
                case let .loading(show):
                    show ? LoadingSpinnerManager.shared.showGeneral() : LoadingSpinnerManager.shared.hide()
                case let .showMessage(message, state):
                    ToastManager.shared.showError(message: message, status: state)
                case let.zeroState(show):
                    show ? (self.mainView.zeroStateView.isHidden = false) : (self.mainView.zeroStateView.isHidden = true)
                }
            }.store(in: &subscriptions)
    }
}

//MARK: - pull To refresh Configurations
extension RepositoriesListVC {
    private func pullToRefresh() {
        refreshControl.tintColor = ColorDesignSystem.Colors.black.color
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        mainView.repositoryTableView.addSubview(refreshControl)
    }
    
    @objc func refresh(sender:AnyObject) {
        viewModel?.LoadRepositoriesList()
        shownIndexes.removeAll()
        refreshControl.endRefreshing()
    }
}


//MARK: - TableView Configurations
extension RepositoriesListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(RepositoryCell.self)") as? RepositoryCell else { return UITableViewCell() }
        cell.data = repoList[exist: indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        // Pagination
        let lastElement = repoList.count - 1
        if indexPath.row == lastElement { viewModel.loadRepoDataIfNeeded(shouldClear: false) }
        
        // Cell Animation
        if !shownIndexes.contains(indexPath) {
            TableViewCellsAnimation.shared.animate(cell)
            shownIndexes.append(indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}
