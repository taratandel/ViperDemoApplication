//
//  Requests.swift
//  What'sThis
//
//  Created by Tara Tandel on 28/08/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import Foundation
//import Alamofire
protocol RequestProtocol: class {
    func requestIsComplete(parsedData: Any?)
}

enum RequestType {
    case list
    case detail
}
class FetchRemoteData {
    
    var gestures: ArrayOfGestures!
    weak var requestProtocol: RequestProtocol?
    private func request (url: String?, /*method: HTTPMethod,*/  parameter: [String: Any?], reqType: RequestType /*header: HTTPHeaders,*/ ) {
        if let path = Bundle.main.path(forResource: "gestures", ofType: "json") {
        let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            self.validateResponse(data, for: reqType)
    }
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
    
    private func validateResponse(_ res: Data?, for type: RequestType) {
        if (res != nil) {
            
            switch type {
            case .list:
                let parsedData = try? JSONDecoder().decode(ArrayOfGestures.self, from: res!)
            case .detail:
                let parsedData = try? JSONDecoder().decode(GestureDetails.self, from: res!)
            }


        }
        
    }
    
    func prepareRequest(endPoint: String? = nil) {
        switch endPoint {
        case "list":
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
