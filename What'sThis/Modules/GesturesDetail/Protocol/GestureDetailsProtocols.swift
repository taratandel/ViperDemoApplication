//
//  Protocols.swift
//  What'sThis
//
//  Created by Tara Tandel on 29/08/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import Foundation

//Presenter -> View
protocol GestureDetailsViewProtocol: class {
//    func reloadData(listOfGestures: [Gestures])
//    func fetchFailed(title: String, message: String, actions: [UIAlertAction])
}

//View -> Presenter
protocol GestureDetailsPresenterProtocol: class {
    
    var interface: GestureDetailsViewProtocol? {set get}
    func detailsViewDidLoad(id: String)
//    func mainViewDidLoad()
}

//Presenter -> Interector
protocol GestureDetailsInputInterectorProtocl: class {
    var presenter: GestureDetailsOutputPresenterProtocol? {set get}
    var gestureDetails: GestureDetails? {set get}
    
    func fetchTheDetails(_ id: String)
}

//Interector -> Presenter
protocol GestureDetailsOutputPresenterProtocol: class {
//    func fetchIsComplete()
    
}

//Presenter -> WireFrame
protocol GestureDetailsWireFramProtocol: class {
    static func creatTheGestureDetailsView(_ view: GestureDetailsViewController)
}
