//
//  Result.swift
//  What'sThis
//
//  Created by Tara Tandel on 30/08/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import Foundation

public enum MovieErrorType: Error {
    case noInternet
    case badRequest
    case serverError
}

enum Result<T> {
    case success(T)
    case failure(MovieErrorType)
}
