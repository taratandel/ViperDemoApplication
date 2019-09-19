//
//  Gestures.swift
//  What'sThis
//
//  Created by Tara Tandel on 19/08/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

struct Gestures: Codable, Searchable, Equatable {
    var name: String
    var id: String
    var thumbNailImageURL: String
}

struct Response: Codable {
    var success: Bool
    var message: String
    var data : [String: [Gestures]]
}

protocol Searchable {
    var name: String {get}
    var id: String {get}
}

enum SearchTypes {
    case all
    case both
    case key
    case values
}
