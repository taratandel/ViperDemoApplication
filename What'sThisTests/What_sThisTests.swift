//
//  What_sThisTests.swift
//  What'sThisTests
//
//  Created by Tara Tandel on 06/08/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import XCTest
@testable import What_sThis

class What_sThisTestsView: XCTestCase {

    class mockWireFrame: GestureListWireFramProtocol {
        static func creatTheView(_ viewRef: ViewController) {
            let list = mockInterector()
            let wireFrame = mockWireFrame()
            let presenter = GestureListPresenter(wireFrame: wireFrame, interector: list)
            viewRef.presenter = presenter

            list.presenter = presenter
        }
        
        
    }

    
    class mockInterector: GestureListInputInterectorProtocl {
        var presenter: GestureListOutputPresenterProtocol?
        
        func fetchGestureData() {
            
        }
        
        
    }
    
    var viewC: ViewController!
    var gestureArrayes: ArrayOfGestures!
    
    var presenterDidCalled: Bool!

    private var topLevelUIUtilities: TopLevelUIUtilities<ViewController>!

    override func setUp() {
        super.setUp()
        presenterDidCalled = false
        viewC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as? ViewController
        mockWireFrame.creatTheView(viewC)
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
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testReloadData() {
        viewC.reloadData(listOfGestures: gestureArrayes)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            XCTAssertEqual(self.viewC.gesturesCollectionView.visibleCells.count, 2)
        } )
    }
}
