//
//  GestureDetailsPresenter.swift
//  What'sThis
//
//  Created by Tara Tandel on 29/08/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import Foundation

class GestureDetailsPresentor: GestureDetailsPresenterProtocol {
    var interface: GestureDetailsViewProtocol?
    private var interector: GestureDetailsInputInterectorProtocl!
    private var router: GestureDetailsWireFrame!
    
    init(interector: GestureDetailsInputInterectorProtocl, router: GestureDetailsWireFrame) {
        self.interector = interector
        self.router = router
    }
    
    func detailsViewDidLoad(id: String) {
        interector.fetchTheDetails(id)
    }
}

extension GestureDetailsPresentor: GestureDetailsOutputPresenterProtocol {
    
}
