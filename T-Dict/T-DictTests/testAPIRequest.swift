//
//  testAPIRequest.swift
//  T-DictTests
//
//  Created by Tiến on 5/10/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import XCTest
@testable import T_Dict

class testAPIRequest: XCTestCase {
    
    var sut: APIService!

    override func setUp() {
        super.setUp()
        sut = APIService.shared
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testAPICallCompelted() {
        
        let promise = expectation(description: "Completion handler invoked")
        
        sut.request(word: "Hello", type: .definitions, method: .get) { (result) in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
                promise.fulfill()
            case .failure(let error):
                XCTAssertNotNil(error)
                promise.fulfill()
            }
        }
        
        sut.getDefines(word: "Hello") { (response) in
            XCTAssertNotNil(response)
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 5)
    }

}
