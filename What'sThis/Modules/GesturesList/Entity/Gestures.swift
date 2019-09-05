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
    var name: String
    var id: String
    var imageName: String

    init(name: String, descr: String, imN: String) {
        self.name = name
        self.id = descr
        self.imageName = imN
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case imageName
    }
}

struct ArrayOfGestures: Codable {
    var gestures: [Gestures]
    
    init(gestures: [Gestures]) {
        self.gestures = gestures
    }
    
    enum CodingKeys: String, CodingKey {
        case gestures
    }
}

struct Response: Codable {
    var success: Bool
    var message: String
    var data : ArrayOfGestures
}
