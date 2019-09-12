//
//  GestureDetailsPresenter.swift
//  What'sThis
//
//  Created by Tara Tandel on 29/08/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import Foundation
import UIKit

class GestureDetailsPresentor: GestureDetailsPresenterProtocol {
    weak var interface: GestureDetailsViewProtocol?
    private var interector: GestureDetailsInputInterectorProtocl?
    private var router: GestureDetailsWireFramProtocol?
    
    private var id: String?
    init(interector: GestureDetailsInputInterectorProtocl, router: GestureDetailsWireFramProtocol) {
        self.interector = interector
        self.router = router
    }
    
    func detailsViewDidLoad(id: String) {
        self.id = id
        interector?.fetchTheDetails(id)
    }
    
    private func openMainView() {
        router?.openMainView()
    }
    
}

extension GestureDetailsPresentor: GestureDetailsOutputPresenterProtocol {
    func fetchIsComplete() {
        guard let data = interector?.gestureDetails else {
            let actions = [UIAlertAction(title: "Retry", style: .cancel, handler: { (action) in
                
            })]
            interface?.fetchFailed(title: "wrong", message: "fetchFaild", actions: actions)
            return
        }
        interface?.reloadData(gestureDetail: data)
    }
    
    func fetchFailed(error: Error, errorMessage: String?) {
        if let message = errorMessage, let id = id{
            switch error {
            case MovieErrorType.badRequest:
                let actions = [UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
                })]
                interface?.fetchFailed(title: "Request Error", message: message, actions: actions)
            case MovieErrorType.noInternet:
                let actions = [UIAlertAction(title: "Retry", style: .cancel, handler: {[weak self] (action) in
                    self?.detailsViewDidLoad(id: id)
                })]
                interface?.fetchFailed(title: "NO Internet", message: message, actions: actions)
            case MovieErrorType.serverError:
                let actions = [UIAlertAction(title: "Retry", style: .cancel, handler: { [weak self](action) in
                    self?.detailsViewDidLoad(id: id)
                })]
                interface?.fetchFailed(title: "Server Error", message: message, actions: actions)
            default:
                let actions = [UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
                })]
                interface?.fetchFailed(title: "Request Failed", message: message, actions: actions)
            }
        } else if let id = id {
            let actions = [UIAlertAction(title: "Retry", style: .cancel, handler: {[weak self] (action) in
                self?.detailsViewDidLoad(id: id)
            }), UIAlertAction(title: "Cancel", style: .destructive, handler: {[weak self] (action) in
                self?.openMainView()
            })]
            interface?.fetchFailed(title: "Oops", message: error.localizedDescription, actions: actions)
        } else {
            let actions = [UIAlertAction(title: "Return", style: .cancel, handler: {
                [weak self] _ in
                self?.openMainView()
            })]
            interface?.fetchFailed(title: "Error", message: "Somthing is extremely wrong please Go back to the first view", actions: actions)
        }
    }
}
