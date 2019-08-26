//
//  EntityTest.swift
//  What'sThisTests
//
//  Created by Tara Tandel on 22/08/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import XCTest
@testable import What_sThis

class EntityTest: XCTestCase {

    var arrayOfGestures: ArrayOfGestures!
    
    override func setUp() {
        super.setUp()
        
        let gesture1 = Gestures(name: "test name", descr: "test desc", imN: "test img name")
        let gesture2 = Gestures(name: "test name2", descr: "test desc2", imN: "test img name2")
        
        arrayOfGestures = ArrayOfGestures(data: [gesture2,gesture1])
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        arrayOfGestures = nil
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGestureEntity() {
        XCTAssertNotNil(arrayOfGestures.data)
        XCTAssertEqual(arrayOfGestures.data.count, 2)
        XCTAssertEqual(arrayOfGestures.data[0].name, "test name2")
        XCTAssertEqual(arrayOfGestures.data[1].name, "test name")
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
}
