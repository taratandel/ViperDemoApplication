//
//  GestureListInterector.swift
//  What'sThis
//
//  Created by Tara Tandel on 19/08/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import Foundation

class GestureListInterector: GestureListInputInterectorProtocl {
    weak var presenter: GestureListOutputPresenterProtocol?
    
    var client: GetListData?
    var gestures: [Gestures]?
    
    func fetchGestureData() {
        client?.getTheData()
    }
}

extension GestureListInterector: ListRequestProtocol {
    func listRequestIsComplete(parsedData: ArrayOfGestures) {
        gestures = parsedData.gestures
        presenter?.fetchIsComplete()
    }
    
    func listRequestFailed(error: Error) {
        
    }
    
    
}
