//
//  What_sThisTests.swift
//  What'sThisTests
//
//  Created by Tara Tandel on 06/08/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import XCTest
@testable import What_sThis

class What_sThisTestsPresenter: XCTestCase {

    var viewC: MockVC!
    var gestureArrayes: ArrayOfGestures!
    
//    var presenterDidCalled: Bool!
//    var fetchDidFailed: Bool!
    


    override func setUp() {
        super.setUp()
        
        viewC = MockVC()
//        presenterDidCalled = false
//        fetchDidFailed = false
        
//        MockWireFrame.creatTheView(viewC)
        
        let gestures = [Gestures(name: "gest1", descr: "gest desc", imN: "FakeImage2"), Gestures(name: "gest2", descr: "gest desc", imN: "FakeImage2")]
        gestureArrayes = ArrayOfGestures(data: gestures)
        

        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        viewC = nil
        gestureArrayes = nil
//        topLevelUIUtilities.tearDownTopLevelUI()
//        topLevelUIUtilities = nil
//        presenterDidCalled = nil
//        fetchDidFailed = nil
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    /* these are viewController tests I have to seperate them this doesnt work

    */
    func testMainViewDidLoad () {
        let wireframe = MockWireFrame()
        let interector = MockInterector()
        let client = MockClient()
        let presenter = GestureListPresenter(wireFrame: wireframe, interector: interector, client: client)
        interector.presenter = presenter
        presenter.mainViewDidLoad()
        
        XCTAssertEqual(interector.gestures?.count, 2)
    }
    
    func testFetchIsComplete () {
        let wireframe = MockWireFrame()
        let interector = MockInterector()
        let client = MockClient()
        let presenter = GestureListPresenter(wireFrame: wireframe, interector: interector, client: client)
        
        presenter.view = viewC
        presenter.gestures = gestureArrayes.data
        interector.presenter = presenter
        presenter.fetchIsComplete()
        
        XCTAssertTrue(viewC.dataReloaded)
    }
    
    func testFetchFailed() {
        let wireframe = MockWireFrame()
        let interector = MockInterector()
        let client = MockClient()
        let presenter = GestureListPresenter(wireFrame: wireframe, interector: interector, client: client)
        
        presenter.view = viewC
        interector.presenter = presenter
        presenter.fetchIsComplete()

        XCTAssertTrue(viewC.fetchFailed)
        
    }
}
