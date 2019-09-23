//
//  UIViewController+Extensions.swift
//  What'sThis
//
//  Created by Tara Tandel on 28/08/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import UIKit

final class Appearances {
    class func setGlobalAppearance() {
        UITabBarItem.appearance().setTitleTextAttributes([.font: UIFont(isBold: false, withSize: 10)], for: .normal)
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.font: UIFont.defaultFont]
        UITextField.appearance(whenContainedInInstancesOf: [UISearchController.self]).defaultTextAttributes = [NSAttributedString.Key.font: UIFont.defaultFont]
        
        UIBarButtonItem.appearance().setTitleTextAttributes([.font: UIFont(isBold: false, withSize: 17)], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([.font: UIFont(isBold: false, withSize: 17)], for: .highlighted)
        UIBarButtonItem.appearance().tintColor = UIColor.red
        UINavigationBar.appearance().tintColor = .white
    }
}

extension Dictionary where Key: Comparable, Value: Equatable {
    func intersect(dict: [Key:Value]) -> [Key:Value] {
        let entriesInSelfAndNotInDict = filter { dict[$0.0] == self[$0.0] }
        return entriesInSelfAndNotInDict.reduce([Key:Value]()) { (res, entry) -> [Key:Value] in
            var res = res
            res[entry.0] = entry.1
            return res
        }
    }
}

extension UIFont {
    convenience init(isBold: Bool, withSize size: CGFloat) {
        self.init(name: isBold ? "Comic Sans MS Bold" : "Comic Sans MS", size: size)!
    }
    
    static var defaultFont: UIFont {
        return UIFont(isBold: false, withSize: 15)
    }
}

extension UINavigationBar {
    
    func shouldRemoveShadow(_ value: Bool) -> Void {
        if value {
            self.setValue(true, forKey: "hidesShadow")
        } else {
            self.setValue(false, forKey: "hidesShadow")
        }
    }
}
