//
//  Protocols.swift
//  What'sThis
//
//  Created by Tara Tandel on 19/08/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import UIKit


//Presenter -> View
protocol GestureListViewProtocol: class {
    func reloadData(listOfGestures: [Gestures])
    func fetchFailed(title: String, message: String, actions: [UIAlertAction])
}

//View -> Presenter
protocol GestureListPresenterProtocol: class {
    
    var view: GestureListViewProtocol? {set get}
    
    func mainViewDidLoad()
    func didSelectGesture(id: String)
}

//Presenter -> Interector
protocol GestureListInputInterectorProtocl: class {
    var presenter: GestureListOutputPresenterProtocol? {set get}
    var client: GetListData? {get set}
    var gestures: [Gestures]? {get set}
    
    func fetchGestureData()
}

//Interector -> Presenter
protocol GestureListOutputPresenterProtocol: class {
    func fetchIsComplete()
    func fetchFailed(error: Error, message: String?)
    
}

//Presenter -> WireFrame
protocol GestureListWireFramProtocol: class {
    static func creatTheView(_ viewRef: ViewController)
    func presentDetailsView(for id: String)
}

// list services
protocol GetListData: class {
    func getTheListData()
}
