//
//  GestureListPresenter.swift
//  What'sThis
//
//  Created by Tara Tandel on 19/08/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import Foundation

class GestureListPresenter: GestureListPresenterProtocol {
    weak var view: GestureListViewProtocol?
    weak var wireFrame: GestureListWireFramProtocol?
    weak var interector: GestureListInputInterectorProtocl?
}

extension GestureListPresenter: GestureListOutputPresenterProtocol {
    
}
