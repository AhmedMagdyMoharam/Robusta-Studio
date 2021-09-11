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
    private var searchDebounceValue = 250 // spending time until re hit action
    private var viewModel: RepositoriesListViewModelProtocol?
    private var refreshControl = UIRefreshControl()
    private var reposList: [RepositoryVMProtocol] { // final gitHub repos list
        viewModel?.reposList.value ?? []
    }
    
    //MARK: - Dealloc methods
    deinit {
        print("DeInit called: \(String(describing: self))")
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    //MARK: - Methods
    class func create(viewModel: RepositoriesListViewModelProtocol) -> RepositoriesListVC {
        /// I usually use Swift Gen (fonts, images, storyboards)
        let vc: RepositoriesListVC = StoryBoardDesignSystem.StoryBoard.home.name.instantiateViewController(identifier: "\(RepositoriesListVC.self)")
        vc.viewModel = viewModel
        return vc
    }
    
    private func setup() {
        guard let viewModel = viewModel else { return }
        self.navigationItem.addTitle(with: ImagesDesignSystem.images.homeHeaderImage.image)
        // Base Setup
        setupBindings()
        // load to refresh
        pullToRefresh()
        // Search bar setup
        mainView.searchBar.delegate = self
        // Load repos Api
        viewModel.LoadRepositoriesList()
    }
    
    private func setupBindings() {
        guard let viewModel = viewModel else { return }
        // Repo List
        viewModel.reposList
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .sink { [ weak self ] _ in
                guard let self = self else { return }
                self.mainView.repositoryTableView.reloadData()
            }.store(in: &subscriptions)
        
        // Search Bar with debounce
        NotificationCenter.default.publisher(for: UISearchTextField.textDidChangeNotification, object: mainView.searchBar.searchTextField)
            .compactMap {(($0.object as? UISearchTextField)?.text ?? "")}
            .debounce(for: .milliseconds(searchDebounceValue), scheduler: RunLoop.main)
            .assign(to: \.searchValue.value, on: viewModel)
            .store(in: &subscriptions)
        
        // pull to refresh
        refreshControllerBinding()
        
        // ViewModel states
        viewModel.state
            .receive(on: DispatchQueue.main)
            .sink { [ weak self ] in
                guard let self = self else { return }
                switch $0 {
                case let .loading(show):
                    show ? self.mainView.repositoryTableView.startImbeddedLoading() : self.mainView.repositoryTableView.stopImbeddedLoading()
                case let .showMessage(message, state):
                    ToastManager.shared.showError(message: message, status: state)
                case let.zeroState(show):
                    show ? (self.mainView.zeroStateView.isHidden = false) : (self.mainView.zeroStateView.isHidden = true)
                }
            }.store(in: &subscriptions)
    }
}

//MARK: - Search Configurations & pull To Refresh
extension RepositoriesListVC: UISearchBarDelegate {
    
    // To AddAny Action when click in Search Button
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        mainView.searchBar.endEditing(true)
        searchBar.resignFirstResponder()
    }
    
    private func pullToRefresh() {
        refreshControl.tintColor = ColorDesignSystem.Colors.black.color
        mainView.repositoryTableView.addSubview(refreshControl)
    }
    
    private func refreshControllerBinding() {
        refreshControl.publisher(for: .valueChanged)
            .sink { [ weak self ] _ in
                guard let self = self else { return }
                self.viewModel?.LoadRepositoriesList()
                self.shownIndexes.removeAll()
                self.refreshControl.endRefreshing()
            }.store(in: &subscriptions)
    }
}


//MARK: - TableView Configurations
extension RepositoriesListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reposList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(RepositoryCell.self)") as? RepositoryCell else { return UITableViewCell() }
        cell.data = reposList[exist: indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        // Pagination
        let lastElement = reposList.count - 1
        if indexPath.row == lastElement { viewModel.loadRepoDataIfNeeded(shouldClear: false) }
        // Cell Animation
        if !shownIndexes.contains(indexPath) {
            AnimationUtility.shared.animate(cell)
            shownIndexes.append(indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = RepoDescriptionVC.create(viewModel: RepoDescriptionViewModel(provider: RepositoryProvider(networkRequest: NativeRequitable()), repoData: reposList[exist: indexPath.row], pageType: .comments))
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}
