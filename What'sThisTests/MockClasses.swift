//
//  MockClasses.swift
//  What'sThisTests
//
//  Created by Tara Tandel on 26/08/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import Foundation
import UIKit
@testable import What_sThis


class MockWireFrame: GestureListWireFramProtocol {
    func presentDetailsView(for id: String) {
        
    }
    
    static func creatTheView(_ viewRef: ViewController) {
        let list = MockInterector(shouldGestureListBeEmpty: false)
        let wireFrame = MockWireFrame()
        let client = MockClient()
        let presenter = GestureListPresenter(wireFrame: wireFrame, interector: list, client: client)
        presenter.view = viewRef
        viewRef.presenter = presenter
        
        list.presenter = presenter
    }    
}

class MockInterector: GestureListInputInterectorProtocl {
    var client: GetListDataProtocol?
    
    var gestures: [String : [Gestures]]?
    var shouldGestureListBeEmpty: Bool = false
    var dataFiltredForTag = false
    weak var presenter: GestureListOutputPresenterProtocol?

    func filterContentForText(_ searchText: String, scope: SearchTypes, in searchDictionary: [String : [Gestures]]?) {
        self.fillGestures()
        presenter?.filteredResults(returnedResult: gestures!)
    }
    
    func retrieveSelectedTag() {
        
    }
    
    init(shouldGestureListBeEmpty: Bool) {
        self.shouldGestureListBeEmpty = shouldGestureListBeEmpty
    }
    
    func fetchGestureData() {
        self.fillGestures()

        presenter?.fetchIsComplete()
    }
    
    private func fillGestures() {
        if !shouldGestureListBeEmpty {
            let g1 = Gestures.init(name: "gest1", id: "1", thumbNailImageURL: "g1")
            let g2 = Gestures(name: "gest1", id: "2", thumbNailImageURL: "g1")
            gestures = ["c1": [g1, g2], "c2": [g2]]
        }
    }
}


class MockOutputInterector: GestureListOutputPresenterProtocol {
    func fetchIsComplete() {
        
    }
    
    func fetchFailed(error: Error, message: String?) {
        
    }
    
    func filteredResults(returnedResult: [String : [Gestures]]) {
        
    }
}

class MockClient: GetListDataProtocol {
    
    weak var requestProtocol: RequestServices?

    func getTheListData() {
        
    }
}

class MockVC: GestureListViewProtocol {

    
    var dataReloaded = false
    var fetchFailed = false
    var dataFiltered = false
    var searchBarReloaded = false
    var errorMessage = ""
    
    var presenter: GestureListPresenterProtocol!
        
    func fetchFailed(title: String, message: String, actions: [UIAlertAction]) {
        self.errorMessage = message
        fetchFailed = true
    }
    
    func reloadData() {
        dataReloaded = true
    }
    
    func reloadFilteredData() {
        dataFiltered = true
    }
    
    func reloadSearchBar() {
        searchBarReloaded = true
    }
}
