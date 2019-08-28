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

    var viewC: ViewController!
    var gestureArrayes: ArrayOfGestures!
    
    var presenterDidCalled: Bool!
    var fetchDidFailed: Bool!
    

    private var topLevelUIUtilities: TopLevelUIUtilities<ViewController>!

    override func setUp() {
        super.setUp()
        
        presenterDidCalled = false
        fetchDidFailed = false
        
        viewC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as? ViewController
        MockWireFrame.creatTheView(viewC)
        
        let gestures = [Gestures(name: "gest1", descr: "gest desc", imN: "FakeImage2"), Gestures(name: "gest2", descr: "gest desc", imN: "FakeImage2")]
        gestureArrayes = ArrayOfGestures(data: gestures)
        
        topLevelUIUtilities = TopLevelUIUtilities<ViewController>()
        topLevelUIUtilities.setupTopLevelUI(withViewController: viewC)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        viewC = nil
        gestureArrayes = nil
        topLevelUIUtilities.tearDownTopLevelUI()
        topLevelUIUtilities = nil
        presenterDidCalled = nil
        fetchDidFailed = nil
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testReloadData() {
        viewC.reloadData(listOfGestures: gestureArrayes)

        let expectation = XCTestExpectation(description: "visible cells are correct")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            XCTAssertEqual(self.viewC.gesturesCollectionView.visibleCells.count, 2)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.3)
    }
    
    func testFetchIsFailed() {
        let actions = [UIAlertAction(title: "Cancel", style: .destructive, handler: { action in
            print("handled")
        })]
        viewC.fetchFailed(title: "title", message: "message", actions: actions)
        
        XCTAssertTrue(viewC.presentedViewController is UIAlertController)
        XCTAssertEqual(viewC.presentedViewController?.title, "title")
    }
    
    func testMainViewDidLoad () {
        let wireframe = MockWireFrame()
        let interector = MockInterector()
        let client = MockClient()
        let presenter = GestureListPresenter(wireFrame: wireframe, interector: interector, client: client)
        interector.presenter = presenter
        
        presenter.view = self
        
        presenter.mainViewDidLoad()
        
        XCTAssertTrue(presenterDidCalled)
    }
    
    func testFetchIsComplete () {
        let wireframe = MockWireFrame()
        let interector = MockInterector()
        let client = MockClient()
        let presenter = GestureListPresenter(wireFrame: wireframe, interector: interector, client: client)
        
        interector.presenter = presenter
        
        presenter.view = self
        
        presenter.fetchIsComplete(gustures: gestureArrayes)
        
        XCTAssertTrue(presenterDidCalled)
    }
    
    func testFetchFailed() {
        let wireframe = MockWireFrame()
        let interector = MockInterector()
        let client = MockClient()
        let presenter = GestureListPresenter(wireFrame: wireframe, interector: interector, client: client)
        
        interector.presenter = presenter
        
        presenter.view = self
        
        presenter.fetchIsComplete(gustures: nil)
        
        XCTAssertTrue(fetchDidFailed)
        XCTAssertFalse(presenterDidCalled)
    }
}

extension What_sThisTestsPresenter: GestureListViewProtocol {
    func fetchFailed(title: String, message: String, actions: [UIAlertAction]) {
        fetchDidFailed = true

    }
    
    func reloadData(listOfGestures: ArrayOfGestures) {
        presenterDidCalled = true
    }
}
