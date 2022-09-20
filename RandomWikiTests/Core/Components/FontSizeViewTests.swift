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
            try view.list().toggle(0).callOnChange(newValue: true)
            try view.list().callOnAppear()
            XCTAssertTrue(UserDefaults.standard.scaledFontEnabled())
        }
        ViewHosting.host(view: view)
        wait(for: [exp], timeout: 5)
    }
    
    func testFontSize() {
        let exp = view.inspection.inspect { view in
            UserDefaults.standard.setFontSize(12)
            try view.list().callOnAppear()
            XCTAssertEqual(try view.actualView().fontSize, 12)
            try view.actualView().fontToggle = false
            try view.list().section(1).vStack(0).view(RandomWiki.CustomSlider.self, 3).callOnChange(newValue: Float(20))
            try view.list().callOnAppear()
            XCTAssertEqual(UserDefaults.standard.fontSize(), 20)
        }
        ViewHosting.host(view: view)
        wait(for: [exp], timeout: 5)
    }
}
