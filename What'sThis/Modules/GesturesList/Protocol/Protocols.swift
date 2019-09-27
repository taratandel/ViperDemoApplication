//
//  Protocols.swift
//  What'sThis
//
//  Created by Tara Tandel on 19/08/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import UIKit


// MARK: - Presenter -> View
protocol GestureListViewProtocol: class {
    func reloadData()
    func fetchFailed(title: String, message: String, actions: [UIAlertAction])
    
    func reloadFilteredData()
    func reloadSearchBar()

}

// MARK: - View -> Presenter
protocol GestureListPresenterProtocol: class {
    
    var view: GestureListViewProtocol? {set get}
    
    func mainViewDidLoad()
    func didSelectGesture(id: String)
    
    func getGesturesForHeader(at indexPath: IndexPath) -> Gestures?
    func getTheNumberOfItemsInSection(_ section: Int) -> Int?
    func getTheTitleHeader(at section: Int) -> String?
    func getTheNumberOfSections() -> Int?
    func shouldFilter(with text: String)
    func retrieveTheList()
    func shouldLoadTagList(tagList: inout TopBarViewController)
}
// MARK: - TopBarView -> Presenter
protocol TopBarPresenterProtcol: class {
    func tagDidSelectedWith(_ header: String)
    func tagDidSelected()
}

// MARK: - Presenter -> Interector
protocol GestureListInputInterectorProtocl: class {
    var presenter: GestureListOutputPresenterProtocol? {set get}
    var client: GetListDataProtocol? {get set}
    var gestures: [String:[Gestures]]? {get set}
    
    func fetchGestureData()
    func filterContentForText(_ searchText: String, scope: SearchTypes, in searchDictionary: [String: [Gestures]]?)
    func retrieveSelectedTag()
}

// MARK: - Interector -> Presenter
protocol GestureListOutputPresenterProtocol: class {
    func fetchIsComplete()
    func fetchFailed(error: Error, message: String?)
    
    func filteredResults(returnedResult: [String: [Gestures]])
    
}

// MARK: - Presenter -> WireFrame
protocol GestureListWireFramProtocol: class {
    static func creatTheView(_ viewRef: ViewController)
    func presentDetailsView(for id: String)
}

// MARK: - list services
protocol GetListDataProtocol: class {
    func getTheListData()
}
