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

    class MockWireFrame: GestureListWireFramProtocol {
        static func creatTheView(_ viewRef: ViewController) {
            let list = MockInterector()
            let wireFrame = MockWireFrame()
            let presenter = GestureListPresenter(wireFrame: wireFrame, interector: list)
            viewRef.presenter = presenter

            list.presenter = presenter
        }
        
        
    }

    
    class MockInterector: GestureListInputInterectorProtocl {
        var presenter: GestureListOutputPresenterProtocol?
        
        func fetchGestureData() {
            let gestures = [Gestures(name: "gest1", description: "gest desc", imageName: "g1"), Gestures(name: "gest2", description: "gest desc", imageName: "g2")]

            presenter?.fetchIsComplete(gustures: ArrayOfGestures(data: gestures))
        }
    }
    
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
        
        let gestures = [Gestures(name: "gest1", description: "gest desc", imageName: "g1"), Gestures(name: "gest2", description: "gest desc", imageName: "g2")]
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
    
//    func testReloadData() {
//        viewC.reloadData(listOfGestures: gestureArrayes)
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
//            XCTAssertEqual(self.viewC.gesturesCollectionView.visibleCells.count, 2)
//        } )
//    }
    
    func testMainViewDidLoad () {
        let wireframe = MockWireFrame()
        let interector = MockInterector()
        let presenter = GestureListPresenter(wireFrame: wireframe, interector: interector)
        
        interector.presenter = presenter
        
        presenter.view = self
        
        presenter.mainViewDidLoad()
        
        XCTAssertTrue(presenterDidCalled)
    }
    
    func testFetchIsComplete () {
        let wireframe = MockWireFrame()
        let interector = MockInterector()
        let presenter = GestureListPresenter(wireFrame: wireframe, interector: interector)
        
        interector.presenter = presenter
        
        presenter.view = self
        
        presenter.fetchIsComplete(gustures: gestureArrayes)
        
        XCTAssertTrue(presenterDidCalled)
    }
    
    func testFetchFailed() {
        let wireframe = MockWireFrame()
        let interector = MockInterector()
        let presenter = GestureListPresenter(wireFrame: wireframe, interector: interector)
        
        interector.presenter = presenter
        
        presenter.view = self
        
        presenter.fetchIsComplete(gustures: nil)
        
        XCTAssertTrue(fetchDidFailed)
        XCTAssertFalse(presenterDidCalled)
    }
}

extension What_sThisTestsPresenter: GestureListViewProtocol {
    func reloadData(listOfGestures: ArrayOfGestures) {
        presenterDidCalled = true
    }
    
    func fetchFailed() {
        fetchDidFailed = true
    }
}
