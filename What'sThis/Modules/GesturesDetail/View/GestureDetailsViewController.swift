//
//  GestureDetailsViewController.swift
//  What'sThis
//
//  Created by Tara Tandel on 29/08/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import UIKit

class GestureDetailsViewController: BaseViewController {
    @IBOutlet weak var gestureImg: UIImageView!
    @IBOutlet weak var gestureDetailTextView: UITextView!
    
    var gestureDetails: GestureDetails?
    var presenter: GestureDetailsPresenterProtocol!
    var id: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        showIndicatorView(with: "wait dg ah ://")
        presenter.detailsViewDidLoad(id: id)
        // Do any additional setup after loading the view.
    }
    
    init (id: String) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
}

extension GestureDetailsViewController: GestureDetailsViewProtocol {
    func reloadData(gestureDetail: GestureDetails) {
        removeIndicator()
        gestureDetails = gestureDetail
        gestureImg.image = gestureDetail.getImage()
        gestureDetailTextView.text = gestureDetail.desc
    }
    
    func fetchFailed(title: String, message: String, actions: [UIAlertAction]) {
        showAlert(title: title, message: message, actions: actions)
    }
}
