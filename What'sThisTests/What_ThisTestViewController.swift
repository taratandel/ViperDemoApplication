////
////  What_ThisTestViewController.swift
////  What'sThisTests
////
////  Created by Tara Tandel on 29/08/2019.
////  Copyright © 2019 Tara Tandel. All rights reserved.
////
//
//import XCTest
//@testable import What_sThis
//
//class What_ThisTestViewController: XCTestCase {
//    
//    var vc: ViewController!
//    var gestureArrayes: ArrayOfGestures!
//
//    private var topLevelUIUtilities: TopLevelUIUtilities<ViewController>!
//    
//    override func setUp() {
//        vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as? ViewController
//        MockWireFrame.creatTheView(vc)
//        let gestures = [Gestures(name: "gest1", descr: "gest desc", imN: "FakeImage2"), Gestures(name: "gest2", descr: "gest desc", imN: "FakeImage2")]
//        gestureArrayes = ArrayOfGestures(data: gestures)
//        topLevelUIUtilities = TopLevelUIUtilities<ViewController>()
//        topLevelUIUtilities.setupTopLevelUI(withViewController: vc)
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDown() {
//        vc = nil
//        topLevelUIUtilities.tearDownTopLevelUI()
//        topLevelUIUtilities = nil
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//    
//    func testReloadData() {
//        vc.reloadData(listOfGestures: gestureArrayes.data)
//        
//        let expectation = XCTestExpectation(description: "visible cells are correct")
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//            XCTAssertEqual(self.vc.gesturesCollectionView.visibleCells.count, 2)
//            expectation.fulfill()
//        }
//        
//        wait(for: [expectation], timeout: 0.3)
//    }
//    
//    func testFetchIsFailed() {
//
//        XCTAssertTrue(self.vc.presentedViewController is UIAlertController)
//        XCTAssertEqual(self.vc.presentedViewController?.title, "Something is Wrong")
//
//    }}
