//
//  What_sThisTestListWireFrame.swift
//  What'sThisTests
//
//  Created by Tara Tandel on 10/10/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import XCTest
@testable import What_sThis

class What_sThisTestListWireFrame: XCTestCase {
    var wireFrame: GestureListWireFrame!

    override func setUp() {
        wireFrame = GestureListWireFrame()
    }

    override func tearDown() {
        wireFrame = nil
    }
    
    func testPresentDetailsView() {
        let detailView = GestureDetailsViewController(id: "2")
        wireFrame.presentDetailsView(with: detailView)
        
        print("\(detailView)", "+++++++")
        print("\(wireFrame.topNavController?.topViewController)")
        XCTAssertTrue(wireFrame.topNavController?.topViewController == detailView)
    }
}
