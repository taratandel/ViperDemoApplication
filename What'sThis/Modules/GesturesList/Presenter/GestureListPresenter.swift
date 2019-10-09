//
//  GestureListPresenter.swift
//  What'sThis
//
//  Created by Tara Tandel on 19/08/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import Foundation
import UIKit

class GestureListPresenter: GestureListPresenterProtocol {
    // MARK: - Delegates
    private var wireFrame: GestureListWireFramProtocol?
    weak var view: GestureListViewProtocol?
    private var interector: GestureListInputInterectorProtocl?
    
    // MARK: - Properties
    private var list: [String: [Gestures]]?
    private var tagList: [String: [Gestures]]?
    private var tagSelected: Bool = false

    // MARK: - Initialization
    init(wireFrame: GestureListWireFramProtocol, interector: GestureListInputInterectorProtocl, client: GetDataProtocol) {
        self.wireFrame = wireFrame
        self.interector = interector
        self.interector?.client = client
    }
    
    // MARK: - GestureListPresenterProtocol
    func mainViewDidLoad () {
        interector?.fetchGestureData()
    }
    
    func didSelectGesture(id: String) {
        wireFrame?.presentDetailsView(for: id)
    }
    
    func shouldLoadTagList(tagList: inout TopBarViewController) {
        if tagSelected { return }
        tagList.delegate = self
        let scopes : [String]? = list?.map {
            $0.key
        }

        guard let tagListScopes = scopes else {
            return
        }

        tagList.scopes = tagListScopes
    }
    
    func getGesturesForHeader(at indexPath: IndexPath) -> Gestures? {
        guard let headerTitle = getTheTitleHeader(at: indexPath.section) else {
            return nil
        }
        return list?[headerTitle]?[indexPath.row]
    }
    
    func getTheNumberOfItemsInSection(_ section: Int) -> Int? {
        guard let headerTitle = getTheTitleHeader(at: section) else {
            return nil
        }
        return list?[headerTitle]?.count
    }
    
    func getTheTitleHeader(at section: Int) -> String? {
        let items = list?.map {
            $0.key
        }
        
        guard let headerItems = items else { return nil }
        return headerItems[section]
    }
    
    func getTheNumberOfSections() -> Int? {
        return list?.count
    }
    
    func shouldFilter(with text: String) {
        //check the situation of the tag list
        if tagSelected {
            interector?.filterContentForText(text, scope: .values, in: list)
        } else {
            interector?.filterContentForText(text, scope: .all, in: nil)
        }
    }
    
    func retrieveTheList() {
        if tagSelected {
            interector?.retrieveSelectedTag()
            return
        }
        list = interector?.gestures
        guard  list != nil else {
            return
        }
        
        view?.reloadFilteredData()
    }
}

// MARK: - GestureListOutputPresenterProtocol
extension GestureListPresenter: GestureListOutputPresenterProtocol {
    func filteredResults(returnedResult: [String : [Gestures]]) {
        list = returnedResult
        view?.reloadFilteredData()
    }
    
    
    func fetchIsComplete() {
        list = interector?.gestures
        guard list != nil else {
            let actions = [UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
                print("Cancel tapped")
            })]
            view?.fetchFailed(title: "Something is Wrong", message: "Please try again", actions: actions)
            return
        }
        
        view?.reloadData()
    }
    
    func fetchFailed(error: Error, message: String?) {
        if message != nil {
            switch error {
            case RequestErrorType.badRequest:
                let actions = [UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
                })]
                view?.fetchFailed(title: "Request Error", message: message!, actions: actions)
            case RequestErrorType.noInternet:
                let actions = [UIAlertAction(title: "Retry", style: .cancel, handler: { [weak self](action) in
                    self?.mainViewDidLoad()
                })]
                view?.fetchFailed(title: "NO Internet", message: message!, actions: actions)
            case RequestErrorType.serverError:
                let actions = [UIAlertAction(title: "Retry", style: .cancel, handler: { [weak self](action) in
                    self?.mainViewDidLoad()
                })]
                view?.fetchFailed(title: "Server Error", message: message!, actions: actions)
            default:
                let actions = [UIAlertAction(title: "Cancel", style: .cancel, handler: {(action) in
                })]
                view?.fetchFailed(title: "Request Failed", message: message!, actions: actions)
            }
        } else {
            let actions = [UIAlertAction(title: "Retry", style: .cancel, handler: { [weak self](action) in
                self?.mainViewDidLoad()
            })]
            view?.fetchFailed(title: "Oops", message: error.localizedDescription, actions: actions)
        }
    }
}

// MARK: - TopBarPresenterProtcol
extension GestureListPresenter: TopBarPresenterProtcol {
    func tagDidSelectedWith(_ header: String) {
        tagSelected = true
        interector?.filterContentForText(header, scope: .key, in: nil)
        view?.reloadSearchBar()
    }
    
    func tagDidSelected() {
        tagSelected = false
        self.retrieveTheList()
        view?.reloadSearchBar()
    }
}
