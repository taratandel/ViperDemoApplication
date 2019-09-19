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
    private var wireFrame: GestureListWireFramProtocol?
    weak var view: GestureListViewProtocol?
    private var interector: GestureListInputInterectorProtocl?
    
    private var list: [String: [Gestures]]?
    init(wireFrame: GestureListWireFramProtocol, interector: GestureListInputInterectorProtocl, client: FetchRemoteData) {
        self.wireFrame = wireFrame
        self.interector = interector
        self.interector?.client = client
    }

    func mainViewDidLoad () {
        interector?.fetchGestureData()
    }
    
    func didSelectGesture(id: String) {
        wireFrame?.presentDetailsView(for: id)
    }
}

extension GestureListPresenter: GestureListOutputPresenterProtocol {
    func filteredResults(returnedResult: [String : [Searchable]]) {
        guard let filteredGestures: [String: [Gestures]] = returnedResult as? [String : [Gestures]] else {return}
        // needs more thinking does not worth the effort the array is big 
            list = filteredGestures
            view?.reloadData(listOfGestures: filteredGestures, listOfHeaders: Array(filteredGestures.keys))
    }
    
    
    func fetchIsComplete() {
        list = interector?.gestures
        guard let listOfGesture = list else {
            let actions = [UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
                print("Cancel tapped")
            })]
            view?.fetchFailed(title: "Something is Wrong", message: "Please try again", actions: actions)
            return
        }
        
        let arrayOfHeaders = Array(listOfGesture.keys)
        view?.reloadData(listOfGestures: listOfGesture, listOfHeaders: arrayOfHeaders)
    }
    
    func fetchFailed(error: Error, message: String?) {
        if message != nil {
            switch error {
            case MovieErrorType.badRequest:
                let actions = [UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
                })]
                view?.fetchFailed(title: "Request Error", message: message!, actions: actions)
            case MovieErrorType.noInternet:
                let actions = [UIAlertAction(title: "Retry", style: .cancel, handler: { [weak self](action) in
                    self?.mainViewDidLoad()
                })]
                view?.fetchFailed(title: "NO Internet", message: message!, actions: actions)
            case MovieErrorType.serverError:
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
        var headerItems: [String] = []
        guard let gestures = list else {
            return nil
        }
        for item in gestures {
            headerItems.append(item.key)
        }
        
        return headerItems[section]
    }
    
    func getTheNumberOfSections() -> Int? {
        return list?.count
    }
    
    func shouldFilter(with text: String, scope: SearchTypes)  {
        interector?.filterContentForText(text, scope: scope)
    }
}
