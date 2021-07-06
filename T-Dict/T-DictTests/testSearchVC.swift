//
//  testSearchVC.swift
//  T-DictTests
//
//  Created by Tiến on 5/10/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import XCTest
@testable import T_Dict

class testSearchVC: XCTestCase {
    
    var vc: SearchViewController!
    var tableView: UITableView!
    var navigationController: UINavigationController!
    var testSearchBar: UISearchBar!
    var testClearButton: UIButton!

    override func setUp() {
        super.setUp()
        vc = SearchViewController()
        tableView = UITableView()
        tableView.register(cellType: SearchHistoryCell.self)
        tableView.register(cellType: SuggestCell.self)
        testSearchBar = UISearchBar()
        testClearButton = UIButton()
        vc.tableView = tableView
        vc.searchBar = testSearchBar
        vc.clearButton = testClearButton
        navigationController = UINavigationController(rootViewController: vc)
        AppSetting.searchHistory = ["Mock History 1", "Mock History 2"]
    }
    
    override func tearDown() {
        super.tearDown()
        vc = nil
        tableView = nil
        testSearchBar = nil
        navigationController = nil
    }
    
    func testSearchHistoryCanBeClear() {
        let clearButton = UIButton()
        clearButton.addTarget(vc,
                              action: #selector(vc.didTapClearSearchHistory(_:)),
                              for: .touchUpInside)
        clearButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(AppSetting.searchHistory.count, 0)
    }
    
    func testSearchBarDidBeginEditing() {
        vc.searchBarTextDidBeginEditing(testSearchBar)
        XCTAssertEqual(vc.tableView.isHidden, true)
    }
    
    func testSearchBarDidEndEditing() {
        vc.searchBarTextDidEndEditing(testSearchBar)
        XCTAssertEqual(vc.tableView.isHidden, true)
    }
    
    func testCancelSearchBar() {
        vc.searchBar.text = "Test"
        vc.searchBarCancelButtonClicked(testSearchBar)
        XCTAssertEqual(vc.searchBar.text, "")
    }
    
    func testPushToDetailsView() {
        vc.pushToDetailsView(word: "random")
        RunLoop.current.run(until: Date())
        guard let _ = navigationController.topViewController as? DetailsViewController else {
            XCTFail()
            return
        }
    }
    
    func testSearchBarSearchButtonClickedSuccess() {
        vc.searchBar.text = "random"
        vc.searchBarSearchButtonClicked(testSearchBar)
        RunLoop.current.run(until: Date())
        guard let _ = navigationController.topViewController as? DetailsViewController else {
            XCTFail()
            return
        }
    }
    
    func testSearchWithEmptySearchBar() {
        vc.searchBarSearchButtonClicked(testSearchBar)
        RunLoop.current.run(until: Date())
        guard let _ = navigationController.topViewController as? SearchViewController else {
            XCTFail()
            return
        }
    }
    
    func testSetupSearchHistoryWithNewWord() {
        AppSetting.searchHistory = ["1"]
        vc.setUpSearchHistory(word: "newWord")
        XCTAssertEqual(AppSetting.searchHistory.count, 2)
    }
    
    func testSetupSearchHistoryWithExistWord() {
        AppSetting.searchHistory = ["1"]
        vc.setUpSearchHistory(word: "1")
        XCTAssertEqual(AppSetting.searchHistory.count, 1)
    }
    
    func testSearchTextChange() {
        vc.searchBar(testSearchBar, textDidChange: "random")
        XCTAssertEqual(vc.searchBarIsEmpty, false)
    }
    
    func testSearchTextIsEmpty() {
        vc.searchBar(testSearchBar, textDidChange: "")
        XCTAssertEqual(vc.searchBarIsEmpty, true)
    }
    
    func testSetRowHeigt() {
        XCTAssertEqual(vc.tableView(tableView, heightForRowAt: IndexPath(row: 0, section: 0)), 50)
    }
    
    func testSelectRow() {
        vc.searchBarIsEmpty = true
        vc.tableView(tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(vc.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0)).isSelected, false)
    }
    
}
