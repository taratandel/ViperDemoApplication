//
//  GestureListWireFrame.swift
//  What'sThis
//
//  Created by Tara Tandel on 19/08/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import Foundation

class GestureListWireFrame: TopViewControllerGettable, GestureListWireFramProtocol {
    
    class func creatTheView(_ viewRef: ViewController) {
        let list = GestureListInterector()
        let wireframe = GestureListWireFrame()
        
        let webClinet = FetchRemoteData(requestProtocol: list)
        
        let presenter: GestureListOutputPresenterProtocol & GestureListPresenterProtocol = GestureListPresenter(wireFrame: wireframe, interector: list, client: webClinet)
        
        viewRef.presenter = presenter
        viewRef.presenter.view = viewRef

        list.presenter = presenter
    }
    
    func presentDetailsView(with view: GestureDetailsViewProtocol) {
        if let detailView = view as? GestureDetailsViewController {
            GestureDetailsWireFrame.creatTheGestureDetailsView(detailView)
            guard let listViewVC = topNavController else { return }
            listViewVC.pushViewController(detailView, animated: !isRunningTests)
        } else {
            // show the error
            return
        }
    }
}
