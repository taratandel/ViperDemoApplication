//
//  Gestures.swift
//  What'sThis
//
//  Created by Tara Tandel on 19/08/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import Foundation
import UIKit

struct Gestures {
    var name: String!
    var description: String!
    var imageName: String!
    
    init(attributes: [String: String]) {
        self.name = attributes[EntityCast.name]
        self.description = attributes[EntityCast.description]
        self.imageName = attributes[EntityCast.image]
    }
}
