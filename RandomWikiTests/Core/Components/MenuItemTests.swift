//
//  MenuItemViewTests.swift
//  RandomWikiTests
//
//  Created by Sean Erickson on 9/19/22.
//

import XCTest
import ViewInspector
@testable import RandomWiki
import SwiftUI

extension MenuItem: Inspectable {}

class MenuItemTests: XCTestCase {
    
    var view: MenuItem<EmptyView>!
    
    override func setUp() {
        super.setUp()
        view = MenuItem(iconName: "TestIcon", iconColor: .black, title: "Test", destination: {EmptyView()})
        continueAfterFailure = false
    }
    
    func testTitle() {
        do {
            let _ = try view.inspect().find(text: "Test")
        } catch { XCTFail() }
    }
    
    func testImage() {
        do {
            let _ = try view.inspect().findAll(ViewType.Image.self, where: { try $0.actualImage().name() == "TestIcon"})
        } catch { XCTFail() }
    }
}
