//
//  GestureListInterector.swift
//  What'sThis
//
//  Created by Tara Tandel on 19/08/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

class GestureListInterector: GestureListInputInterectorProtocl {
    weak var presenter: GestureListOutputPresenterProtocol?
    
    var client: GetListDataProtocol?
    var gestures: [String:[Gestures]]?
    private var resultGestures: [String:[Gestures]]?
    func fetchGestureData() {
        client?.getTheListData()
        
    }
    
    func filterContentForText(_ searchText: String, scope: SearchTypes, in searchDictionary: [String: [Gestures]]?) {
        var returnedResult = [String: [Gestures]]()
        let objectToSearch: [String:[Gestures]]
        if searchDictionary != nil {
            resultGestures = resultGestures == nil ? searchDictionary! : resultGestures
            objectToSearch = resultGestures!
        } else if gestures != nil {
            objectToSearch = gestures!
        } else { return }
        
        let searchText = searchText.lowercased()
        
        switch scope {
            // search without selecting any case scenario 1
        case .all:
            returnedResult = objectToSearch.filter {
                let result =  $0.key.lowercased().contains(searchText) || $0.value.map{$0.name.lowercased()}.contains(searchText)
                return result
            }
        case .both:
            let returnedkeys = objectToSearch.filter {
                let result = ($0.key.lowercased().contains(searchText))
                return result
                }
            for (key, array) in returnedkeys {
                returnedResult[key] = array.filter { $0.name.lowercased().contains(searchText) }
            }
        case .values:
            for (key, array) in objectToSearch {
                returnedResult[key] = array.filter { $0.name.lowercased().contains(searchText) }
            }
            // search just the key in the case the tags are selected
        case .key:
            returnedResult = objectToSearch.filter {
                let result = $0.key.lowercased().contains(searchText)
                return result
            }
        }
        resultGestures = searchDictionary == nil ? returnedResult : resultGestures
        presenter?.filteredResults(returnedResult: returnedResult)
    }
    
    func retrieveSelectedTag() {
        guard let resultGestures = self.resultGestures else  { return }
        presenter?.filteredResults(returnedResult: resultGestures)
    }
}

extension GestureListInterector: RequestServices {
    func requestIsComplete(_ response: DataResponse<Any>) {
        switch response.result {
        case .success(_):
            do {
                let parsedData = try JSONDecoder().decode(Response.self, from: response.data ?? Data())
                if parsedData.success {
                    gestures = parsedData.data
                    presenter?.fetchIsComplete()
                }
                else {
                    presenter?.fetchFailed(error: RequestErrorType.serverError, message: parsedData.message)
                }
            }
            catch {
                presenter?.fetchFailed(error: RequestErrorType.badRequest, message: nil)
            }
        case .failure(let error):
            presenter?.fetchFailed(error: error, message: nil)
        }
    }
}
