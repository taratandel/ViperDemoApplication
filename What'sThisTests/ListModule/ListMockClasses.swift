//
//  MockClasses.swift
//  What'sThisTests
//
//  Created by Tara Tandel on 26/08/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

@testable import What_sThis


class MockWireFrame: GestureListWireFramProtocol {
    static func creatTheView(_ viewRef: ViewController) {
        
    }
    
    var detailsViewPresented = false
    
    func presentDetailsView(with view: GestureDetailsViewProtocol) {
        detailsViewPresented = true
    }
//
//    static func creatTheView(_ viewRef: ViewController) {
//        let list = MockInterector(shouldGestureListBeEmpty: false)
//        let wireFrame = MockWireFrame()
//        let client = MockClient()
//        let presenter = MockPresenter()
//
//        presenter.view = viewRef
//        viewRef.presenter = presenter
//
//        list.presenter = presenter
//    }
}

class MockInterector: GestureListInputInterectorProtocl {
    var client: GetDataProtocol?
    
    var gestures: [String : [Gestures]]?
    var shouldGestureListBeEmpty: Bool = false
    var dataFiltredForTag = false
    var inited = false
    
    weak var presenter: GestureListOutputPresenterProtocol?
    
    func filterContentForText(_ searchText: String, scope: SearchTypes, in searchDictionary: [String : [Gestures]]?) {
        self.fillGestures()
        presenter?.filteredResults(returnedResult: gestures!)
    }
    
    func retrieveSelectedTag() {
        
    }
    
    init(shouldGestureListBeEmpty: Bool) {
        self.inited = true
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
            self.gestures = ["c1": [g1, g2], "c2": [g2]]
        }
    }
}


class MockOutputInterector: GestureListOutputPresenterProtocol {
    var fetchCompleted = false
    var fetchFailedError:  Error?
    var dataFiltered = false
    var returnedResult: [String : [Gestures]]?
    
    var inited = false
    
    init() {
        self.inited = true
    }
    
    func fetchIsComplete() {
        fetchCompleted = true
    }
    
    func fetchFailed(error: Error, message: String?) {
        fetchFailedError = error
    }
    
    func filteredResults(returnedResult: [String : [Gestures]]) {
        self.returnedResult = returnedResult
        dataFiltered = true
    }
}

class MockClient: GetDataProtocol {
    weak var requestProtocol: RequestServices?
    var requestShouldFail = false
    var fileName: String = ""
    var fileExtention: String = ""
    var errorType: Error?
    
    var inited = false
    
    init() {
        self.inited = true
    }

    func getTheListData(url: String?, method: HTTPMethod, parameter: Parameters?, header: HTTPHeaders?) {
        if (errorType != nil) {
            requestProtocol?.requestFaild(errorType!)
        } else if let data = readFromFile() {
            requestProtocol?.requestIsComplete(data)
        } else {
            requestProtocol?.requestIsComplete(Data())
        }
    }

    func shouldRequest(for fileName: String, with fileExtention: String) {
        self.fileName = fileName
        self.fileExtention = fileExtention
    }

    private func readFromFile() -> Data? {
        if let path = Bundle.main.path(forResource: fileName, ofType: fileExtention) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
            } catch  {
                return nil
            }
        }
        return nil
    }
}

class MockVC: GestureListViewProtocol {

    var dataReloaded = false
    var fetchFailed = false
    var dataFiltered = false
    var searchBarReloaded = false
    var errorMessage = ""
    
    var presenter: GestureListPresenterProtocol!
    
    var inited = false
    
    init() {
        self.inited = true
    }
    
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

class MockPresenter: GestureListPresenterProtocol {
    weak var view: GestureListViewProtocol?

    var mainViewDidLoadCalled = false
    var id = ""
    var stringFilter = ""
    var tagRetrieved = false
    
    func mainViewDidLoad() {
      self.mainViewDidLoadCalled = true
    }
    
    func didSelectGesture(id: String) {
        self.id = id
    }
    
    func getGesturesForHeader(at indexPath: IndexPath) -> Gestures? {
        return Gestures(name: "fakeName", id: "fakeId", thumbNailImageURL: "fakeThumbnail")
    }
    
    func getTheNumberOfItemsInSection(_ section: Int) -> Int? {
        return 2
    }
    
    func getTheTitleHeader(at section: Int) -> String? {
        return "fakeTitle"
    }
    
    func getTheNumberOfSections() -> Int? {
        return 1
    }
    
    func shouldFilter(with text: String) {
        self.stringFilter = text
    }
    
    func retrieveTheList() {
        self.tagRetrieved = true
    }
    
    func shouldLoadTagList(tagList: inout TopBarViewController) {
        tagList.scopes = ["first","second"]
    }
}
