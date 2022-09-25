//
//  MenuViewTests.swift
//  RandomWikiTests
//
//  Created by Sean Erickson on 9/16/22.
//

import XCTest
import ViewInspector
import SwiftUI
@testable import RandomWiki

extension MenuView: Inspectable {}
extension MenuContentsView: Inspectable {}
extension MenuItemModifier: Inspectable {}

class MenuViewTests: XCTestCase {
    
    var view: MenuView!
    
    override func setUp() {
        super.setUp()
        view = MenuView(store: StoreManager(), width: 300, isOpen: false, menuClose: {}, favoritesAction: {_ in})
        continueAfterFailure = false
    }
    
    func testMenuOpen() {
        var check = 0
        view = MenuView(store: StoreManager(), width: 300, isOpen: true, menuClose: {check+=1}, favoritesAction: {_ in})
        let exp = view.inspection.inspect { view in
            try view.vStack(0).zStack(0).geometryReader(0).callOnTapGesture()
        }
        ViewHosting.host(view: view)
        wait(for: [exp], timeout: 5)
        XCTAssertEqual(check, 1)
    }
    
    @MainActor func testMenuContents() {
        
        view = MenuView(store: StoreManager(), width: 300, isOpen: true, menuClose: {}, favoritesAction: {_ in})
        let exp = view.inspection.inspect { view in
            try view.actualView().viewModel.menuSelected = false
            let arr = view.findAll(RandomWiki.MenuContentsView.self)
            try arr[0].modifier(RandomWiki.MenuItemModifier.self).actualView().selected = true
            XCTAssertTrue(try view.actualView().viewModel.menuSelected)
        }
        ViewHosting.host(view: view)
        wait(for: [exp], timeout: 5)
    }
}
