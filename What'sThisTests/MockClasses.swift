//
//  MockClasses.swift
//  What'sThisTests
//
//  Created by Tara Tandel on 26/08/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import Foundation
import UIKit
@testable import What_sThis


class MockWireFrame: GestureListWireFramProtocol {
    static func creatTheView(_ viewRef: ViewController) {
        let list = MockInterector()
        let wireFrame = MockWireFrame()
        let client = MockClient()
        let presenter = GestureListPresenter(wireFrame: wireFrame, interector: list, client: client)
        presenter.view = viewRef
        viewRef.presenter = presenter
        
        list.presenter = presenter
    }
    
    
}

class MockInterector: GestureListInputInterectorProtocl {
    var gestures: [Gestures]?
    var client: FetchRemoteData?
    
    var presenter: GestureListOutputPresenterProtocol?
    
    func fetchGestureData() {
        let g1 = Gestures.init(name: "gest1", descr: "gest1 desc", imN: "g1")
        let g2 = Gestures(name: "gest1", descr: "gest1 desc", imN: "g1")
        gestures = [Gestures]()
        gestures?.append(g1)
        gestures?.append(g2)
        presenter?.fetchIsComplete()
    }
}


class MockOutputInterector: GestureListOutputPresenterProtocol {
    var vc: ViewController!
    func fetchIsComplete() {
        guard let vcUnwrapped = vc else {
            return
        }
        vcUnwrapped.showAlert(title: "fakeTitle", message: "fake message", actions: [UIAlertAction(title: "cancel", style: .cancel, handler: {action in})])
    }
}

class MockClient: FetchRemoteData {
    
    override func prepareRequest(endPoint: String?, completionHandler: @escaping (ArrayOfGestures?, Error?) -> Void) {
        let g1 = Gestures.init(name: "gest1", descr: "gest1 desc", imN: "g1")
        let g2 = Gestures(name: "gest1", descr: "gest1 desc", imN: "g1")
        var gestureL = [Gestures]()
        gestureL.append(g1)
        gestureL.append(g2)
        completionHandler(ArrayOfGestures(data: gestureL), nil)
    }
}

class MockVC: ViewController {
    var dataReloaded = false
    var fetchFailed = false
    
    override func reloadData(listOfGestures: [Gestures]) {
        dataReloaded = true
    }
    
    override func fetchFailed(title: String, message: String, actions: [UIAlertAction]) {
        fetchFailed = true
    }
}
