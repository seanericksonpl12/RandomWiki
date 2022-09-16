//
//  ContentViewTests.swift
//  RandomWikiTests
//
//  Created by Sean Erickson on 9/15/22.
//

import XCTest
@testable import RandomWiki

@MainActor class ContentViewTests: XCTestCase {
    
    var view: ContentView?
    var viewModel: ContentView.ContentViewModel?
    
     override func setUp() {
        continueAfterFailure = false
        view = ContentView()
        viewModel = ContentView.ContentViewModel()
    }
    
    func testInitialLoad() {
        XCTAssertEqual(viewModel?.currentArticle.url?.absoluteString, "https://en.wikipedia.org/wiki/Special:Random")
    }
}
