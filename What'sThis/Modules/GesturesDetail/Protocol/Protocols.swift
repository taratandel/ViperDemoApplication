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
    func reloadData(listOfGestures: [Gestures])
    func fetchFailed(title: String, message: String, actions: [UIAlertAction])
}

//View -> Presenter
protocol GestureDetailsPresenterProtocol: class {
    
    var view: GestureListViewProtocol? {set get}
    
    func mainViewDidLoad()
}

//Presenter -> Interector
protocol GestureDetailsInputInterectorProtocl: class {
    var presenter: GestureListOutputPresenterProtocol? {set get}
    var client: FetchRemoteData? {get set}
    var gestures: [Gestures]? {get set}
    
    func fetchGestureData()
}

//Interector -> Presenter
protocol GestureDetailsOutputPresenterProtocol: class {
    func fetchIsComplete()
    
}

//Presenter -> WireFrame
protocol GestureDetailsWireFramProtocol: class {
    static func creatTheGestureDetailsView(_ viewRef: ViewController)
}
