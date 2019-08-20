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
        
        let presenter: GestureListOutputPresenterProtocol & GestureListPresenterProtocol = GestureListPresenter()
        let list = GestureListInterector()
        let wireframe = GestureListWireFrame()
        viewRef.presenter = presenter
        viewRef.presenter.view = viewRef
        viewRef.presenter.interector = list
        viewRef.presenter.wireframe = wireframe
        viewRef.presenter.interector?.presenter = presenter
    }
}
