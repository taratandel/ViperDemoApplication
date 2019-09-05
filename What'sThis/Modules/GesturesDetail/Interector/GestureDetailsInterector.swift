//
//  GestureDetailsInterector.swift
//  What'sThis
//
//  Created by Tara Tandel on 29/08/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import Foundation

class GestureDetailsInterector: GestureDetailsInputInterectorProtocl {
    
    var presenter: GestureDetailsOutputPresenterProtocol?
    var gestureDetails: GestureDetails?
    var client: GetDetailsData?
    
    func fetchTheDetails(_ id: String) {
        client.g
    }
}

extension GestureListInterector: DetailRequestProtocol {
    
}
