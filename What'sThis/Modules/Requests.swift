//
//  Requests.swift
//  What'sThis
//
//  Created by Tara Tandel on 28/08/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import Foundation
//import Alamofire

class FetchRemoteData {
    
    var gestures: ArrayOfGestures!
    
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
    
    func prepareRequest(endPoint: String? = nil, completionHandler: @escaping (ArrayOfGestures?, Error?) -> Void) {
        switch endPoint {
        case "end":
            print("end")
        default:
            if let path = Bundle.main.path(forResource: "gestures", ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let parsedData = try JSONDecoder().decode(ArrayOfGestures.self, from: data)
                    completionHandler(parsedData, nil)
                } catch  {
                    print("error")
                    completionHandler(nil, error)
                }
            } else {
                completionHandler(nil, nil)
            }
        }
    }
}
