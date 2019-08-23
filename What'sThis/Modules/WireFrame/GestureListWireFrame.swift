//
//  GestureListWireFrame.swift
//  What'sThis
//
//  Created by Tara Tandel on 19/08/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import Foundation

class GestureListWireFrame: GestureListWireFramProtocol {
    
    class func creatTheView(_ viewRef: ViewController) {
        let list = GestureListInterector()
        let wireframe = GestureListWireFrame()
        
        let presenter: GestureListOutputPresenterProtocol & GestureListPresenterProtocol = GestureListPresenter(wireFrame: wireframe, interector: list)

        viewRef.presenter = presenter
        viewRef.presenter.view = viewRef

        list.presenter = presenter
    }
}
