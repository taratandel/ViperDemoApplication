//
//  MockClasses.swift
//  What'sThisTests
//
//  Created by Tara Tandel on 26/08/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import Foundation
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
    var client: FetchRemoteData?
    
    var presenter: GestureListOutputPresenterProtocol?
    
    func fetchGestureData() {
        let g1 = Gestures.init(name: "gest1", descr: "gest1 desc", imN: "g1")
        let g2 = Gestures(name: "gest1", descr: "gest1 desc", imN: "g1")
        var gestures = [Gestures]()
        gestures.append(g1)
        gestures.append(g2)
        let aOg = ArrayOfGestures(data: gestures)
        presenter?.fetchIsComplete(gustures: aOg)
    }
}

class MockOutputInterector: GestureListOutputPresenterProtocol {
    var gestures: ArrayOfGestures?
    func fetchIsComplete(gustures: ArrayOfGestures?) {
        gestures = gustures
    }
}

class MockClient: FetchRemoteData {
    
}
