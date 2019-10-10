//
//  What_sThisTestInterector.swift
//  What'sThisTests
//
//  Created by Tara Tandel on 28/08/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import XCTest

@testable import What_sThis

class What_sThisTestInterector: XCTestCase {
    
    var interector: GestureListInterector!
    var client: MockClient!
    var presenter: MockOutputInterector!
    override func setUp() {
        interector = GestureListInterector()
        presenter = MockOutputInterector()
        
        interector.presenter = presenter
        
        client = MockClient()
        interector.client = client
        client.requestProtocol = interector
    }
    
    override func tearDown() {
        interector.presenter = nil
        interector.client = nil
        interector = nil
        client = nil
    }
    
    func testFetchGestureData() {
        client.shouldRequest(for: "gestures", with: "json")
        interector.client = client
        interector.fetchGestureData()
        
        XCTAssertEqual(interector.gestures?.count, 2)
    }
    
    func testFetchGestureDataWithFailedRequest() {
        client.errorType = RequestErrorType.badRequest
        interector.client = client
        interector.fetchGestureData()
        
        XCTAssertEqual(presenter.fetchFailedError?.localizedDescription, RequestErrorType.badRequest.localizedDescription)
    }
    
    func testFetchGestureDataWithWrongData() {
        interector.fetchGestureData()
        
        XCTAssertEqual(presenter.fetchFailedError?.localizedDescription, RequestErrorType.badRequest.localizedDescription)
    }
    
    func testRetrieveSelectedTagWithoutFilteringBefore() {
        client.shouldRequest(for: "gestures", with: "json")
        interector.client = client
        interector.fetchGestureData()
        presenter.dataFiltered = false
        interector.retrieveSelectedTag()
        
        XCTAssertFalse(presenter.dataFiltered)
    }
    
    func testRetrieveSelectedTag() {
        presenter.dataFiltered = false
        client.shouldRequest(for: "gestures", with: "json")
        interector.client = client
        interector.fetchGestureData()
        interector.filterContentForText("f", scope: .all, in: nil)
        
        interector.retrieveSelectedTag()
        
        XCTAssertTrue(presenter.dataFiltered)
    }
    
    func testFilterContentForTextWithScopeAll() {
        presenter.dataFiltered = false
        client.shouldRequest(for: "gestures", with: "json")
        interector.client = client
        interector.fetchGestureData()
        interector.filterContentForText("category1", scope: .all, in: nil)
        XCTAssertTrue(presenter.returnedResult?.count == 1)
        XCTAssertTrue(presenter.returnedResult?["category1"]?.count == 5)
    }
    
    func testFilterWithScopeAllAndNoJointAlphabet() {
        presenter.dataFiltered = false
        client.shouldRequest(for: "gestures", with: "json")
        interector.client = client
        interector.fetchGestureData()
        interector.filterContentForText("category1Name1", scope: .all, in: nil)
        XCTAssertTrue(presenter.returnedResult?.count == 1)
        XCTAssertTrue(presenter.returnedResult?["category1"]?.count == 1)
    }
    
    func testFilterContentForTextWithScopeBoth() {
        presenter.dataFiltered = false
        client.shouldRequest(for: "gestures", with: "json")
        interector.client = client
        interector.fetchGestureData()
        interector.filterContentForText("category1", scope: .both, in: nil)
        XCTAssertTrue(presenter.returnedResult?.count == 1)
        XCTAssertTrue(presenter.returnedResult?["category1"]?.count == 1)
    }
    
    func testFilterForBothWithJustMatchingValue() {
        presenter.dataFiltered = false
        client.shouldRequest(for: "gestures", with: "json")
        interector.client = client
        interector.fetchGestureData()
        interector.filterContentForText("name", scope: .both, in: nil)
        
        XCTAssertTrue(presenter.returnedResult?.count == 0)
    }
    
    func testFilterForValues() {
        presenter.dataFiltered = false
        client.shouldRequest(for: "gestures", with: "json")
        interector.client = client
        interector.fetchGestureData()
        interector.filterContentForText("name", scope: .values, in: nil)
        
        XCTAssertTrue(presenter.returnedResult?.count == 2)
        XCTAssertTrue(presenter.returnedResult?["category1"]?.count == 5)
        XCTAssertTrue(presenter.returnedResult?["category2"]?.count == 5)
    }
    
    func testFilterForValuesWithMatch() {
        presenter.dataFiltered = false
        client.shouldRequest(for: "gestures", with: "json")
        interector.client = client
        interector.fetchGestureData()
        interector.filterContentForText("name1", scope: .values, in: nil)
        
        XCTAssertTrue(presenter.returnedResult?.count == 2)
        XCTAssertTrue(presenter.returnedResult?["category1"]?.count == 1)
        XCTAssertTrue(presenter.returnedResult?["category2"]?.count == 2)
        
    }
    
    func testFilterScopeValueWith1Match() {
        presenter.dataFiltered = false
        client.shouldRequest(for: "gestures", with: "json")
        interector.client = client
        interector.fetchGestureData()
        interector.filterContentForText("c2Name3", scope: .values, in: nil)
        
        XCTAssertTrue(presenter.returnedResult?.count == 1)
        XCTAssertTrue(presenter.returnedResult?["category2"]?.count == 1)
    }
    
    func testFilterForKeyswithMatchingValue() {
        presenter.dataFiltered = false
        client.shouldRequest(for: "gestures", with: "json")
        interector.client = client
        interector.fetchGestureData()
        interector.filterContentForText("category1", scope: .key, in: nil)
        
        XCTAssertTrue(presenter.returnedResult?.count == 1)
        XCTAssertTrue(presenter.returnedResult?["category1"]?.count == 5)
        
    }
    
    func testFilterForKeysWithNoMatchingValue() {
        presenter.dataFiltered = false
        client.shouldRequest(for: "gestures", with: "json")
        interector.client = client
        interector.fetchGestureData()
        interector.filterContentForText("c1", scope: .key, in: nil)
        
        XCTAssertTrue(presenter.returnedResult?.count == 0)
    }
    
    func testFilterWithGivenDictionary() {
        presenter.dataFiltered = false
        client.shouldRequest(for: "gestures", with: "json")
        interector.client = client
        interector.fetchGestureData()
        let gesture = Gestures(name: "name1", id: "1", thumbNailImageURL: "thumbnail")
        let searchDictionary = ["c1" : [gesture]]
        interector.filterContentForText("c1", scope: .key, in: searchDictionary)
        
        XCTAssertTrue(presenter.returnedResult?["c1"]?.count == 1)
    }
}
