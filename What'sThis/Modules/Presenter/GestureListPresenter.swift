//
//  GestureListPresenter.swift
//  What'sThis
//
//  Created by Tara Tandel on 19/08/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import Foundation

class GestureListPresenter: GestureListPresenterProtocol {
    private var wireFrame: GestureListWireFramProtocol?
    var view: GestureListViewProtocol?
    private var interector: GestureListInputInterectorProtocl?
    
    init(wireFrame: GestureListWireFramProtocol, interector: GestureListInputInterectorProtocl) {
        self.wireFrame = wireFrame
        self.interector = interector
    }

    func mainViewDidLoad () {
        interector?.fetchGestureData()
    }
}

extension GestureListPresenter: GestureListOutputPresenterProtocol {
    func fetchIsComplete(gustures: ArrayOfGestures?) {
        guard let listOfGesture = gustures else {
            return
        }
        view?.reloadData(listOfGestures: listOfGesture)
    }
}
