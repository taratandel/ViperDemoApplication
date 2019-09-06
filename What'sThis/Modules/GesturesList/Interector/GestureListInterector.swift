//
//  GestureListInterector.swift
//  What'sThis
//
//  Created by Tara Tandel on 19/08/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import Foundation
import Alamofire

class GestureListInterector: GestureListInputInterectorProtocl {
    weak var presenter: GestureListOutputPresenterProtocol?
    
    var client: GetListDataProtocol?
    var gestures: [Gestures]?
    
    func fetchGestureData() {
        client?.getTheListData()
        
    }
}

extension GestureListInterector: RequestServices {
    func requestIsComplete(_ response: DataResponse<Any>) {
        switch response.result {
        case .success(_):
            do {
                let parsedData = try JSONDecoder().decode(Response.self, from: response.data ?? Data())
                if parsedData.success {
                    gestures = parsedData.data.gestures
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
