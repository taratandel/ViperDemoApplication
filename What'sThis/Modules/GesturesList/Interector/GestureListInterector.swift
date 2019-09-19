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
    
    func fetchGestureData() {
        client?.getTheListData()
        
    }
    
    func filterContentForText(_ searchText: String, scope: SearchTypes) {
        var returnedResult = [String: [Gestures]]()
        guard let objectToSearch = gestures else { return }
        switch scope {
        case .all:
            returnedResult = objectToSearch.filter {
                let result =  $0.key.contains(searchText) || $0.value.map{$0.name}.contains(searchText)
                return result
            }
        case .both:
            let returnedkeys = objectToSearch.filter {
                let result = ($0.key.contains(searchText))
                return result
                }
            for (key, array) in returnedkeys {
                returnedResult[key] = array.filter { $0.name.contains(searchText) }
            }
        case .values:
            for (key, array) in objectToSearch {
                returnedResult[key] = array.filter { $0.name.contains(searchText) }
            }
        case .key:
            returnedResult = objectToSearch.filter {
                let result = $0.key.contains(searchText.lowercased())
                return result
            }
        }
        presenter?.filteredResults(returnedResult: returnedResult)
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
                    presenter?.fetchFailed(error: MovieErrorType.serverError, message: parsedData.message)
                }
            }
            catch {
                presenter?.fetchFailed(error: MovieErrorType.badRequest, message: nil)
            }
        case .failure(let error):
            presenter?.fetchFailed(error: error, message: nil)
        }
    }
}
