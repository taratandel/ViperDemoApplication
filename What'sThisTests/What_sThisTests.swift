//
//  What_sThisTests.swift
//  What'sThisTests
//
//  Created by Tara Tandel on 06/08/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import XCTest
@testable import What_sThis

class What_sThisTests: XCTestCase {

    var viewC: ViewController!
    var gestureArrayes: ArrayOfGestures!
    private var topLevelUIUtilities: TopLevelUIUtilities<ViewController>!

    override func setUp() {
        super.setUp()
        
        viewC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as? ViewController
        
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
        
        XCTAssertEqual(viewC.gesturesCollectionView.visibleCells.count, 2)
    }

}
