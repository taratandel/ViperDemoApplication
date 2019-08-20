//
//  Gestures.swift
//  What'sThis
//
//  Created by Tara Tandel on 19/08/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import Foundation
import UIKit

struct Gestures: Codable {
    var name: String!
    var description: String!
    var imageName: String!
    
    enum CodingKeys: String, CodingKey {
        case name
        case description
        case imageName
    }
}

struct ArrayOfGestures: Codable {
    var data: [Gestures]!
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}
