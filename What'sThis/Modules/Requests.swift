//
//  Requests.swift
//  What'sThis
//
//  Created by Tara Tandel on 28/08/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import Foundation
import Alamofire

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

class FetchRemoteData {
    weak var requestProtocol: RequestServices?
    
    init(requestProtocol: RequestServices) {
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
}

extension FetchRemoteData: GetDataProtocol {
    func getTheListData(url: String?, method: HTTPMethod, parameter: Parameters?, header: HTTPHeaders?) {
        self.request(url: url, method: method, parameter: parameter, header: header) {
            response in
            switch response.result {
            case .success(_):
                guard let data = response.data else {
                    self.requestProtocol?.requestFaild(RequestErrorType.badRequest)
                    return
                }
                self.requestProtocol?.requestIsComplete(data)
            case .failure(let error):
                self.requestProtocol?.requestFaild(error)
                
            }
        }
    }
    
//    func getTheListData() {
//        self.request(url: RequestType.list.path, method: .get, parameter: nil, header: nil) {
//            response in
//            switch response.result {
//            case .success(_):
//                guard let data = response.data else {
//                    self.requestProtocol?.requestFaild(RequestErrorType.badRequest)
//                    return
//                }
//                self.requestProtocol?.requestIsComplete(data)
//            case .failure(let error):
//                self.requestProtocol?.requestFaild(error)
//                
//            }
//        }
//    }
}

//extension FetchRemoteData: GetDetailsDataProtocol {
//    func getDetails(id: String) {
//        self.request(url: RequestType.detail(gestureID: id).path, method: .get, parameter: nil, header: nil) {
//            response in
//            self.requestProtocol?.requestIsComplete(response)
//        }
//    }
//}
