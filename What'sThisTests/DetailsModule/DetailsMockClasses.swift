//
//  DetailsMockClasses.swift
//  What'sThisTests
//
//  Created by Tara Tandel on 10/10/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

@testable import What_sThis


class MockDetailsVc: GestureDetailsViewProtocol {
    var id: String!
    init (id: String) {
        self.id = id
    }
    func reloadData(gestureDetail: GestureDetails) {
        
    }
    
    func fetchFailed(title: String, message: String, actions: [UIAlertAction]) {
        
    }
}
