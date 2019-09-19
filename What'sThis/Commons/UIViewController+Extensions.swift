//
//  UIViewController+Extensions.swift
//  What'sThis
//
//  Created by Tara Tandel on 28/08/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import UIKit

extension UIViewController {

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
