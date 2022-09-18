//
//  ContentViewTests.swift
//  RandomWikiTests
//
//  Created by Sean Erickson on 9/15/22.
//

import XCTest
@testable import RandomWiki

@MainActor class ContentViewTests: XCTestCase {
    
    var view: ContentView!
    
     override func setUp() {
         super.setUp()
        continueAfterFailure = false
        view = ContentView()
    }
    
    func testInitialLoad() {
        XCTAssertEqual(view.viewModel.currentArticle.url?.absoluteString, "https://en.wikipedia.org/wiki/Special:Random")
    }
    
    func testReload() {
        let previousID = view.viewModel.currentArticle.id
        view.viewModel.getArticle()
        XCTAssertTrue(view.viewModel.loading)
        XCTAssertNotEqual(previousID, view.viewModel.currentArticle.id)
    }
    
    func testClearData() {
        view.viewModel.currentArticle.saved = true
        view.viewModel.clearData()
        XCTAssertFalse(view.viewModel.currentArticle.saved)
    }
}
