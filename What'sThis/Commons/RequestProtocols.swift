//
//  RequestProtocols.swift
//  What'sThis
//
//  Created by Tara Tandel on 05/09/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import Foundation

protocol ListRequestProtocol: class {
    func listRequestIsComplete(parsedData: ArrayOfGestures)
    func listRequestFailed(error: Error, errorMessage: String?)
}

protocol ReqeustServices: ListRequestProtocol, DetailRequestProtocol {
    
}

protocol DetailRequestProtocol {}
