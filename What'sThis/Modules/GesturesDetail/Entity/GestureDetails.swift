//
//  GestureDetails.swift
//  What'sThis
//
//  Created by Tara Tandel on 29/08/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//
import UIKit

struct GestureDetails {
    let isFavorite: Bool!
    let desc: String!
    let imgName: String!
    
    func getImage() -> UIImage? {
        return UIImage(named: imgName)
    }
}
