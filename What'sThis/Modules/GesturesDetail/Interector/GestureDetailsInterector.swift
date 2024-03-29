//
//  GestureDetailsInterector.swift
//  What'sThis
//
//  Created by Tara Tandel on 29/08/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import Foundation
import Alamofire

class GestureDetailsInterector: GestureDetailsInputInterectorProtocl {
    
    weak var presenter: GestureDetailsOutputPresenterProtocol?
    var gestureDetails: GestureDetails?
    var client: GetDataProtocol?
    
    func fetchTheDetails(_ id: String) {
        client?.getTheListData(url: RequestType.detail(gestureID: id).path, method: .get, parameter: nil, header: nil)
    }
}

extension GestureDetailsInterector: RequestServices {
    func requestIsComplete(_ response: Data) {
        do {
            let parsedData = try JSONDecoder().decode(DetailsResponse.self, from: response)
            if parsedData.success {
                gestureDetails = parsedData.data
                presenter?.fetchIsComplete()
            } else {
                presenter?.fetchFailed(error: RequestErrorType.serverError, errorMessage: parsedData.message)
            }
        }
        catch {
            presenter?.fetchFailed(error: RequestErrorType.badRequest, errorMessage: nil)
        }

    }
    
    func requestFaild(_ error: Error) {
        presenter?.fetchFailed(error: error, errorMessage: nil)
    }
    
//    func requestIsComplete(_ response: DataResponse<Any>) {
//        switch response.result {
//        case .success(_):
//            do {
//                let parsedData = try JSONDecoder().decode(DetailsResponse.self, from: response.data ?? Data())
//                if parsedData.success {
//                    gestureDetails = parsedData.data
//                    presenter?.fetchIsComplete()
//                } else {
//                    presenter?.fetchFailed(error: RequestErrorType.serverError, errorMessage: parsedData.message)
//                }
//            }
//            catch {
//                presenter?.fetchFailed(error: RequestErrorType.badRequest, errorMessage: nil)
//            }
//        case .failure(let error):
//            presenter?.fetchFailed(error: error, errorMessage: nil)
//        }
//    }
}
