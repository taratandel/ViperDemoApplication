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

    var presenter: GestureListPresenter!

    override func setUp() {
        super.setUp()
        let wireFrame = MockWireFrame()
        let interector = MockInterector()
        let client = MockClient()
        let vc = MockVC()
        presenter = GestureListPresenter(wireFrame: wireFrame, interector: interector, client: client)
        presenter.view = vc

    }

    override func tearDown() {
        presenter = nil
    }
    
    func testMainViewDidLoad() {
        presenter.mainViewDidLoad()
        
        XCTAssertNotNil(presenter.list)
    }
    
    /* these are viewController tests I have to seperate them this doesnt work

    */
//    func testMainViewDidLoad () {
//        let wireframe = MockWireFrame()
//        let interector = MockInterector()
//        let client = MockClient()
//        let presenter = GestureListPresenter(wireFrame: wireframe, interector: interector, client: client)
//        interector.presenter = presenter
//        presenter.mainViewDidLoad()
//
//        XCTAssertEqual(interector.gestures?.count, 2)
//    }
//
//    func testFetchIsComplete () {
//        let wireframe = MockWireFrame()
//        let interector = MockInterector()
//        let client = MockClient()
//        let presenter = GestureListPresenter(wireFrame: wireframe, interector: interector, client: client)
//
//        presenter.view = viewC
//        presenter.gestures = gestureArrayes.data
//        interector.presenter = presenter
//        presenter.fetchIsComplete()
//
//        XCTAssertTrue(viewC.dataReloaded)
//    }
//
//    func testFetchFailed() {
//        let wireframe = MockWireFrame()
//        let interector = MockInterector()
//        let client = MockClient()
//        let presenter = GestureListPresenter(wireFrame: wireframe, interector: interector, client: client)
//
//        presenter.view = viewC
//        interector.presenter = presenter
//        presenter.fetchIsComplete()
//
//        XCTAssertTrue(viewC.fetchFailed)
//
//    }
}
