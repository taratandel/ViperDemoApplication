//
//  Requests.swift
//  What'sThis
//
//  Created by Tara Tandel on 28/08/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import Foundation
import Alamofire
protocol ListRequestProtocol: class {
    func listRequestIsComplete(parsedData: ArrayOfGestures)
    func listRequestFailed(error: Error, errorMessage: String?)
}

extension ListRequestProtocol {
    func listRequestFailed(error: Error, errorMessage: String? = nil) {
        return listRequestFailed(error: error, errorMessage: errorMessage)
    }
}

enum RequestType {
    case list
    case detail(gestureID: String)
    
    var path: String {
        switch self {
        case let .detail(gestureID):
            return String(format: "%@/detail?id=%@", EndPoints.serverEndPoint,gestureID)
        case .list:
            return String(format: "%@/list", EndPoints.serverEndPoint)
        }
    }
}

class FetchRemoteData: GetListData {
    var gestures: ArrayOfGestures!
    weak var requestProtocol: ListRequestProtocol?
    
    init(requestProtocol: ListRequestProtocol) {
        self.requestProtocol = requestProtocol
    }
    
    private func request (url: String?, method: HTTPMethod,  parameter: Parameters?, header: HTTPHeaders?, completionHandler: @escaping (_ result: DataResponse<Any>) -> Void) {
        if let reqURL = url {
            Alamofire.request(reqURL, method: method, parameters: parameter, encoding: JSONEncoding.default, headers: header).responseJSON {
                response in
                completionHandler(response)
                
            }
        }
    }
    
    func getTheData() {
        self.request(url: RequestType.list.path, method: .get, parameter: nil, header: nil) {
            response in
            switch response.result {
            case .success(_):
                do {
                    let parsedData = try JSONDecoder().decode(Response.self, from: response.data ?? Data())
                    if parsedData.success {self.requestProtocol?.listRequestIsComplete(parsedData: parsedData.data)}
                    else {
                        self.requestProtocol?.listRequestFailed(error: MovieErrorType.serverError, errorMessage: parsedData.message)
                    }
                }
                catch {
                    
                    self.requestProtocol?.listRequestFailed(error: MovieErrorType.badRequest)
                }
            case .failure(let error):
                self.requestProtocol?.listRequestFailed(error: error)
            }
        }
    }
}

