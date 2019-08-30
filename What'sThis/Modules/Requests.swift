//
//  Requests.swift
//  What'sThis
//
//  Created by Tara Tandel on 28/08/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import Foundation
//import Alamofire
protocol RequestProtocol {
    func requestIsComplete()
}
class FetchRemoteData {
    
    var gestures: ArrayOfGestures!
    var requestProtocol
    private func request (url: String?, /*method: HTTPMethod,*/  parameter: [String: Any?] /*header: HTTPHeaders,*/ ) {
        
    }
//    private func getTheData(url: String?, completionHandler: @escaping (ArrayOfGestures?, Error?) -> Void, method: HTTPMethod, headers: HTTPHeaders?, parameters: [String: Any]) {
//        if let reqUrl = url {
//            Alamofire.request(reqUrl, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseData {
//                response in
//                switch response.result{
//                case .success(let value):
//                    self.validateResponse(value)
//                    completionHandler(self.gestures, nil)
//                case .failure(let err):
//                    completionHandler(nil, err)
//                }
//                self.validateResponse(response)
//
//
//            }
//        } else {
//
//        }
//    }
    
    private func validateResponse(_ res: Any) {
        
    }
    
    func prepareRequest(endPoint: String? = nil) {
        switch endPoint {
        case "list":
//            let method = .GET
            let URL = "listURL"
        case "details":
            if let path = Bundle.main.path(forResource: "gestures", ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let parsedData = try JSONDecoder().decode(ArrayOfGestures.self, from: data)
//                    completionHandler(parsedData, nil)
                } catch  {
                    print("error")
//                    completionHandler(nil, error)
                }
            } else {
//                completionHandler(nil, nil)
            }
        default:
            if let path = Bundle.main.path(forResource: "gestures", ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let parsedData = try JSONDecoder().decode(ArrayOfGestures.self, from: data)
//                    completionHandler(parsedData, nil)
                } catch  {
                    print("error")
//                    completionHandler(nil, error)
                }
            } else {
//                completionHandler(nil, nil)
            }
        }
    }
}
