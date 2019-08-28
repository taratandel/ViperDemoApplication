//
//  UIViewController+Extensions.swift
//  What'sThis
//
//  Created by Tara Tandel on 28/08/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, actions: [UIAlertAction], completion: (() -> Void)? = nil)  {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach{alertController.addAction($0)}
        self.present(alertController, animated: true, completion: completion)
    }
}
