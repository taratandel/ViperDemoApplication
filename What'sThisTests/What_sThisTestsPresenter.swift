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
    var vc: MockVC!

    override func setUp() {
        super.setUp()
        self.setUpView(with: false)
    }

    override func tearDown() {
        presenter.view = nil
        presenter = nil
        vc = nil
    }
    
    func testMainViewDidLoad() {
        vc.dataReloaded = false
        presenter.mainViewDidLoad()
        XCTAssertTrue(vc.dataReloaded)
    }
    
    func testMainViewDidLoadWithEmptyList() {
        self.setUpView(with: true)
        vc.fetchFailed = false
        presenter.mainViewDidLoad()
        XCTAssertTrue(vc.fetchFailed)
    }
    
    func testShouldLoadTag() {
        var tagList = TopBarViewController(nibName: nil, bundle: nil)
        presenter.mainViewDidLoad()
        presenter.shouldLoadTagList(tagList: &tagList)
        XCTAssertNotNil(tagList.scopes)
    }
    
    func testShouldLoadTagWithEmptyList() {
        self.setUpView(with: true)
        var tagList = TopBarViewController(nibName: nil, bundle: nil)
        presenter.mainViewDidLoad()
        presenter.shouldLoadTagList(tagList: &tagList)
        XCTAssertNil(tagList.scopes)
    }
    
    func testGetTheTitleHeader() {
        presenter.mainViewDidLoad()
        let gestureHeaders = presenter.getTheTitleHeader(at: 0)
        XCTAssertTrue(gestureHeaders == "c1")
    }
    
    func testGetGesturesForHeader() {
        presenter.mainViewDidLoad()
        let gestures = presenter.getGesturesForHeader(at: IndexPath(item: 0, section: 0))
        XCTAssertTrue(gestures?.id == "1")
        
    }
    
    func testGetGesturesForHeaderWithEmptyList() {
        self.setUpView(with: true)
        presenter.mainViewDidLoad()
        let gestures = presenter.getGesturesForHeader(at: IndexPath(row: 0, section: 0))
        XCTAssertNil(gestures)
    }
    
    func testGetTheNumberOfItemsInSection() {
        presenter.mainViewDidLoad()
        let no1 = presenter.getTheNumberOfItemsInSection(0)
        let no2 = presenter.getTheNumberOfItemsInSection(1)
        
        XCTAssertTrue((no1 == 2 && no2 == 1))
    }
    
    func testGetTheNumberOfItemsInsectionWithEmptyList() {
        self.setUpView(with: true)
        presenter.mainViewDidLoad()
        let no = presenter.getTheNumberOfItemsInSection(0)
        XCTAssertNil(no)
    }
    
    func testGetTheNumberOfSection() {
        presenter.mainViewDidLoad()
        let noOfSections = presenter.getTheNumberOfSections()
        
        XCTAssertTrue(noOfSections == 2)
    }
    
    func testShouldFilterWithoutAnyTagSelected() {
        vc.dataFiltered = false
        presenter.mainViewDidLoad()
        presenter.shouldFilter(with: "some fake String")
        XCTAssertTrue(vc.dataFiltered)
    }
    
    func testShouldFilterWithTagSelected() {
        vc.dataFiltered = false
        let topBar = TopBarViewController()
        topBar.delegate = presenter
        topBar.scopes = ["scope1", "scope2"]
        topBar.buttonClicked(at: 0, shouldSelect: true)
        presenter.shouldFilter(with: "some fake String")
        XCTAssertTrue(vc.dataFiltered)
    }
    
    func testRetrieveTheListWithEmptyList() {
        vc.searchBarReloaded = false
        vc.dataFiltered = false
        let topBar = TopBarViewController()
        topBar.delegate = presenter
        topBar.scopes = nil
        topBar.buttonClicked(at: 0, shouldSelect: false)
        
        XCTAssertTrue((vc.searchBarReloaded && !vc.dataFiltered))
    }
    
    func testRetrieveTheListWithTagSelected() {
        presenter.mainViewDidLoad()
        vc.dataFiltered = false
        vc.searchBarReloaded = false
        
        var tagList = TopBarViewController(nibName: nil, bundle: nil)
        presenter.mainViewDidLoad()
        presenter.shouldLoadTagList(tagList: &tagList)
        tagList.buttonClicked(at: 0, shouldSelect: true)
        
        presenter.retrieveTheList()
        
        XCTAssertTrue((vc.searchBarReloaded && vc.dataFiltered))


    }
    
    func testRetriveTheList() {
        presenter.mainViewDidLoad()
        vc.dataFiltered = false
        vc.searchBarReloaded = false
        
        let topBar = TopBarViewController()
        topBar.delegate = presenter
        topBar.scopes = nil
        topBar.buttonClicked(at: 0, shouldSelect: false)
        
        XCTAssertTrue((vc.searchBarReloaded && vc.dataFiltered))
    }

    
    func testFetchFaildWithNilMessage() {
        presenter.fetchFailed(error: RequestErrorType.badRequest, message: nil)
        XCTAssertTrue(vc.errorMessage == RequestErrorType.badRequest.localizedDescription)
    }
    
    func testFetchFaildWithMessageAndErrorTypeBadRequest() {
        presenter.fetchFailed(error: RequestErrorType.badRequest, message: "this is badRequest")
        XCTAssertTrue(vc.errorMessage == "this is badRequest")

    }
    
    func testFetchFaildWithMessageAndErrorTypeNoInternet() {
        presenter.fetchFailed(error: RequestErrorType.noInternet, message: "you don't have internet")
        XCTAssertTrue(vc.errorMessage == "you don't have internet")
        
    }
    
    func testFetchFaildWithMessageAndErrorTypeServerError() {
        presenter.fetchFailed(error: RequestErrorType.serverError, message: "server Error")
        XCTAssertTrue(vc.errorMessage == "server Error")
        
    }
    
    func testFetchFaildWithMessageAndNoErrorType() {
        presenter.fetchFailed(error: NSError(domain: "some domain", code: 1, userInfo: nil), message: "generic error")
        XCTAssertTrue(vc.errorMessage == "generic error")
        
    }
    
    func setUpView(with shouldBeEmpty: Bool) {
        let list = MockInterector(shouldGestureListBeEmpty: shouldBeEmpty)
        let wireFrame = MockWireFrame()
        let client = MockClient()
        vc = MockVC()
        presenter = GestureListPresenter(wireFrame: wireFrame, interector: list, client: client)
        presenter.view = vc
        vc.presenter = presenter
        list.presenter = presenter
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
