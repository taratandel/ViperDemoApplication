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
    
    func fetchGestureData() {
        self.fetchData() {
            response, error in
            self.presenter?.fetchIsComplete(gustures: response)
        }
    }
    
    private func fetchData(completionHandler: @escaping (ArrayOfGestures?, Error?) -> Void) {
        client?.prepareRequest(completionHandler: completionHandler)
    }
}
