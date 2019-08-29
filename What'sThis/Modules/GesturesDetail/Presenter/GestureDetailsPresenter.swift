//
//  GestureDetailsPresenter.swift
//  What'sThis
//
//  Created by Tara Tandel on 29/08/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import Foundation

class GestureDetailsPresentor: GestureDetailsPresenterProtocol {
    var interector: GestureDetailsInputInterectorProtocl!
    var interface: GestureDetailsViewProtocol!
    var router: GestureDetailsWireFrame!
}

extension GestureDetailsPresentor: GestureDetailsOutputPresenterProtocol {
    
}
