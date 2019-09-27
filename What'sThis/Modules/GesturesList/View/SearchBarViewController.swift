//
//  TopBarViewController.swift
//  What'sThis
//
//  Created by Tara Tandel on 11/09/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import UIKit

class SearchBarViewController {
    weak var viewForSearch: UISearchResultsUpdating?
    weak var viewForSearchResult: UIViewController?
    
    lazy var searchController: UISearchController = {
        UISearchController(searchResultsController: viewForSearchResult)
    }()

    init(for viewForSearch: UISearchResultsUpdating, showOn viewForSearchResult: UIViewController? = nil) {
        self.viewForSearch = viewForSearch
        self.viewForSearchResult = viewForSearchResult
        self.setupSearch()
        
    }
    
    func setupSearch() {
        searchController.searchResultsUpdater = viewForSearch
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "search here"
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func deactiveSearchBar() {
        searchController.searchBar.text = nil
        searchController.searchBar.placeholder = "search here"
        searchController.isActive = false
    }
}
