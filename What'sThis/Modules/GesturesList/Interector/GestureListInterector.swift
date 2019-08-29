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
    
    var client: FetchRemoteData?
    var gestures: [Gestures]?
    
    func fetchGestureData() {
        self.fetchData() {
            response, error in
            self.gestures = response?.data
            self.presenter?.fetchIsComplete()
        }
    }
    
    private func fetchData(completionHandler: @escaping (ArrayOfGestures?, Error?) -> Void) {
        client?.prepareRequest(completionHandler: completionHandler)
    }
}
