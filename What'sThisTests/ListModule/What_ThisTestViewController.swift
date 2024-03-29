//
//  What_ThisTestViewController.swift
//  What'sThisTests
//
//  Created by Tara Tandel on 29/08/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import XCTest
@testable import What_sThis

class What_ThisTestViewController: XCTestCase {
    
    var vc: ViewController!
    var presenter: MockPresenter!

    private var topLevelUIUtilities: TopLevelUIUtilities<ViewController>!
    
    override func setUp() {
        presenter = MockPresenter()
        vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as? ViewController
        vc.presenter = presenter
                topLevelUIUtilities = TopLevelUIUtilities<ViewController>()
        topLevelUIUtilities.setupTopLevelUI(withViewController: vc)
    }

    override func tearDown() {
        vc = nil
        topLevelUIUtilities.tearDownTopLevelUI()
        topLevelUIUtilities = nil
    }
    
    func testReloadData() {
        vc.reloadData()
        XCTAssertEqual(vc.taglistVC.scopes?.count, 2)
        XCTAssertTrue(presenter.mainViewDidLoadCalled)
    }
    
    func testReloadFilteredData() {
        vc.showIndicatorView(with: "some string")
        XCTAssertNotNil(vc.indicatorView)
        vc.reloadFilteredData()
        XCTAssertNil(vc.indicatorView)
    }
    
    func testFetchFailed() {
        let action = [UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
        })]

        vc.fetchFailed(title: "fakeTitle", message: "fakeMessage", actions: action)
        
        XCTAssertTrue(vc.presentedViewController?.isKind(of: UIAlertController.self) ?? false)
    }
    
    func testReloadSearchBar() {
        vc.reloadSearchBar()
        
        XCTAssertTrue(vc.topBarView.searchBarIsEmpty())
    }
    
    func testDidSelectCollectionView() {
        vc.gesturesCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: UICollectionView.ScrollPosition.centeredHorizontally)
        let selectedPath = vc.gesturesCollectionView.indexPathsForSelectedItems
        XCTAssertTrue(selectedPath?.count == 1)
        XCTAssertEqual(selectedPath, [IndexPath(row: 0, section: 0)])
    }
}
