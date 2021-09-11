//
//  RepositoriesListView.swift
//  RobustaStudioTask
//
//  Created by ahmed moharam on 10/09/2021.
//

import Foundation
import UIKit

class RepositoriesListView: UIView {
    
    //MARK: - Outlets
    @IBOutlet weak var repositoryTableView: UITableView!
    @IBOutlet weak var zeroStateView: ZeroStateView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - Properties
    
    //MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        designSetup()
    }
    
    //MARK: - Methods
    private func designSetup() {
        //SearchBar Setup
        SearchBarDesignSetup()
        //TableView Setup
        setupRepositoriesTable()
        //ZeroState Design Setup
        zeroStateSetup()
    }
    
    private func SearchBarDesignSetup() {
        searchBar.tintColor = ColorDesignSystem.Colors.black.color
        searchBar.placeholder = "Search ..."
        searchBar.searchTextField.config(font: UIFont(name: AppFonts.regularHelvetica, size: 15) ?? UIFont(), color: ColorDesignSystem.Colors.black.color)
        searchBar.barTintColor = .clear
        searchBar.setBackgroundImage(UIImage.init(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
    }
    
    private func setupRepositoriesTable() {
        repositoryTableView.backgroundColor = .clear
        repositoryTableView.separatorStyle = .none
        repositoryTableView.showsVerticalScrollIndicator = false
        repositoryTableView.showsHorizontalScrollIndicator = false
    }
    
    private func zeroStateSetup() {
        zeroStateView.customSetup(title: "Repositories", body: "No repositories yet! \n Please search by another repo name.")
        zeroStateView.isHidden = true
    }
}
