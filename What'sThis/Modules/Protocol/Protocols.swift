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
    func reloadData(listOfGestures: ArrayOfGestures)
}

//View -> Presenter
protocol GestureListPresenterProtocol: class {
    
    var view: GestureListViewProtocol? {set get}
    var interector: GestureListInputInterectorProtocl? {set get}
    var wireframe: GestureListWireFramProtocol? {set get}
    
    func mainViewDidLoad()
}

//Presenter -> Interector
protocol GestureListInputInterectorProtocl: class {
    
    var presenter: GestureListOutputPresenterProtocol? {set get}
    
    func fetchGestureData()
}

//Interector -> Presenter
protocol GestureListOutputPresenterProtocol: class {
    
    func fetchIsComplete(gustures: ArrayOfGestures?)
    
}

//Presenter -> WireFrame
protocol GestureListWireFramProtocol: class {
    static func creatTheView(_ viewRef: ViewController)
}
