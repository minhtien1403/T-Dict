//
//  testDetailVC.swift
//  T-DictTests
//
//  Created by Tiến on 5/10/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import XCTest
@testable import T_Dict

class testDetailVC: XCTestCase {
    
    var vc: DetailsViewController!
    var segmentControl: UISegmentedControl!
    
    override func setUp() {
        super.setUp()
        vc = DetailsViewController(word: "Hello")
        segmentControl = UISegmentedControl()
    }
    
    override func tearDown() {
        super.tearDown()
        vc = nil
        segmentControl = nil
    }
    
    func testScreenStyeCanBeChange() {
        
    }
}
