//
//  IndicatorViewController.swift
//  What'sThis
//
//  Created by Tara Tandel on 06/09/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import UIKit

class IndicatorViewController: UIViewController {

    @IBOutlet weak var indicatorLabel: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    private var indicatorLabelText: String
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.startAnimating()
        indicatorLabel.text = indicatorLabelText
        // Do any additional setup after loading the view.
    }
    
    init(indicatorMessage: String) {
        self.indicatorLabelText = indicatorMessage
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
}
