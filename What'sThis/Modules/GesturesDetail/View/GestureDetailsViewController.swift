//
//  GestureDetailsViewController.swift
//  What'sThis
//
//  Created by Tara Tandel on 29/08/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import UIKit

class GestureDetailsViewController: UIViewController {
    @IBOutlet weak var gestureImg: UIImageView!
    @IBOutlet weak var gestureDetail: UITextView!
    
    var gestureDetails: GestureDetails?
    var presenter: GestureDetailsPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
}
