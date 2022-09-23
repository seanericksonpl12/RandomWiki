//
//  FontSizeViewTests.swift
//  RandomWikiTests
//
//  Created by Sean Erickson on 9/19/22.
//

import XCTest
import ViewInspector
@testable import RandomWiki

extension FontSizeView: Inspectable {}
extension CustomSlider: Inspectable {}

class FontSizeViewTests: XCTestCase {
    
    var view: FontSizeView!
    
    override func setUp() {
        super.setUp()
        view = FontSizeView()
        continueAfterFailure = false
    }
    
    func testFontToggle() {
        let exp = view.inspection.inspect { view in
            try view.actualView().fontToggle = false
            XCTAssertFalse(UserDefaults.standard.scaledFontEnabled())
            try view.actualView().fontToggle = true
            XCTAssertTrue(UserDefaults.standard.scaledFontEnabled())
        }
        ViewHosting.host(view: view)
        wait(for: [exp], timeout: 5)
    }
    
    func testFontSize() {
        let exp = view.inspection.inspect { view in
            try view.actualView().fontSize = 12
            XCTAssertEqual(try view.actualView().fontSize, 12)
            try view.actualView().fontToggle = false
            try view.actualView().fontSize = 20
            XCTAssertEqual(try view.list().section(1).vStack(0).view(RandomWiki.CustomSlider.self, 3).actualView().value, 20)
        }
        ViewHosting.host(view: view)
        wait(for: [exp], timeout: 5)
    }
}
