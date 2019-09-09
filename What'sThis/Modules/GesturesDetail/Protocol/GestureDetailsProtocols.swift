//
//  Protocols.swift
//  What'sThis
//
//  Created by Tara Tandel on 29/08/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import Foundation
import UIKit
//Presenter -> View
protocol GestureDetailsViewProtocol: class {
    func reloadData(gestureDetail: GestureDetails)
    func fetchFailed(title: String, message: String, actions: [UIAlertAction])
}

//View -> Presenter
protocol GestureDetailsPresenterProtocol: class {
    
    var interface: GestureDetailsViewProtocol? {set get}
    func detailsViewDidLoad(id: String)
}

//Presenter -> Interector
protocol GestureDetailsInputInterectorProtocl: class {
    var presenter: GestureDetailsOutputPresenterProtocol? {set get}
    var gestureDetails: GestureDetails? {set get}
    
    func fetchTheDetails(_ id: String)
}

//Interector -> Presenter
protocol GestureDetailsOutputPresenterProtocol: class {
    func fetchIsComplete()
    func fetchFailed(error: Error, errorMessage: String?)
    
}

//Presenter -> WireFrame
protocol GestureDetailsWireFramProtocol: class {
    static func creatTheGestureDetailsView(_ view: GestureDetailsViewController)
    func openMainView()
}

// details request
protocol GetDetailsDataProtocol: class {
    func getDetails(id: String)
}
