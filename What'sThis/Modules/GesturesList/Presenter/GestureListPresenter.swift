//
//  GestureListPresenter.swift
//  What'sThis
//
//  Created by Tara Tandel on 19/08/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import Foundation
import UIKit

class GestureListPresenter: GestureListPresenterProtocol {
    private var wireFrame: GestureListWireFramProtocol?
    var view: GestureListViewProtocol?
    private var interector: GestureListInputInterectorProtocl?
    
//    var gestures: [Gestures]?
    
    init(wireFrame: GestureListWireFramProtocol, interector: GestureListInputInterectorProtocl, client: FetchRemoteData) {
        self.wireFrame = wireFrame
        self.interector = interector
        self.interector?.client = client
    }

    func mainViewDidLoad () {
        interector?.fetchGestureData()
    }
    
    func didSelectGesture(id: String) {
        wireFrame?.presentDetailsView(for: id)
    }
}

extension GestureListPresenter: GestureListOutputPresenterProtocol {
    
    
    func fetchIsComplete() {
        guard let listOfGesture = interector?.gestures else {
            let actions = [UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
                print("Cancel tapped")
            })]
            view?.fetchFailed(title: "Something is Wrong", message: "Please try again", actions: actions)
            return
        }
        view?.reloadData(listOfGestures: listOfGesture)
    }
}
