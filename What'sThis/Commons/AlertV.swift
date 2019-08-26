//
//  AlertV.swift
//  What'sThis
//
//  Created by Tara Tandel on 26/08/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import UIKit

class AlertController {
    
}

struct ButtonsAction {
    let title: String!
    let style: UIAlertAction.Style
    let handler: () -> Void
}

extension UIAlertController {
    func showAlert(buttons: [ButtonsAction]?) -> UIAlertController {
        let alert = self
        guard let alertButtons = buttons else {
            return alert
        }
        for button in alertButtons {
            let alertAction = UIAlertAction(title: button.title, style: button.style, handler: {action in
                button.handler()
            })
            alert.addAction(alertAction)
        }
        
        return alert
    }
}
