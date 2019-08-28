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
        presenter?.fetchIsComplete(gustures: fetchData())
    }
    
    private func fetchData() -> ArrayOfGestures? {
        
        if let path = Bundle.main.path(forResource: "gestures", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let parsedData = try JSONDecoder().decode(ArrayOfGestures.self, from: data)
                return parsedData
            } catch  {
                print("error")
                return nil
            }
        } else {
            return nil
        }
    }
}
