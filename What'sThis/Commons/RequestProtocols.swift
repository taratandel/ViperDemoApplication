//
//  RequestProtocols.swift
//  What'sThis
//
//  Created by Tara Tandel on 05/09/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import Foundation
import Alamofire

protocol ReqeustServices: class {
    func requestIsComplete(_ response: DataResponse<Any>)
}

