//
//  What_sThisTestInterector.swift
//  What'sThisTests
//
//  Created by Tara Tandel on 28/08/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import XCTest
@testable import What_sThis

class What_sThisTestInterector: XCTestCase {

    var interector: GestureListInterector!
    var gestures: ArrayOfGestures!
    
    override func setUp() {
        interector = GestureListInterector()
        let presenter: GestureListOutputPresenterProtocol = MockOutputInterector()
        
        interector.presenter = presenter
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        interector.presenter = nil
        interector = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFetchGestureData() {
        interector.fetchGestureData()
    }
    
    
}
