//
//  GestureDetailsWireFrame.swift
//  What'sThis
//
//  Created by Tara Tandel on 29/08/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import Foundation

class GestureDetailsWireFrame: GestureDetailsWireFramProtocol {
    
    static func creatTheGestureDetailsView(_ view: GestureDetailsViewController) {
        let interector = GestureDetailsInterector()
        
        let wireFrame = GestureDetailsWireFrame()
        
        let presenter: GestureDetailsPresenterProtocol & GestureDetailsOutputPresenterProtocol = GestureDetailsPresentor(interector: interector, router: wireFrame)
        
        view.presenter = presenter
        view.presenter.interface = view
        
        interector.presenter = presenter
    }
}
