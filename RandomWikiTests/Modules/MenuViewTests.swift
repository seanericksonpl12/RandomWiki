//
//  MenuViewTests.swift
//  RandomWikiTests
//
//  Created by Sean Erickson on 9/16/22.
//

import XCTest
import SwiftUI
@testable import RandomWiki

@MainActor class MenuViewTests: XCTestCase {
    var view: MenuView!
    @State var isOpen: Bool = false
    @State var menuClose: SimpleClosure = {}
    @State var favoritesAction: ArticleClosure = {_ in}
    
    override func setUp() {
        super.setUp()
        view = MenuView(width: 300, isOpen: isOpen, menuClose: menuClose, favoritesAction: favoritesAction)
        continueAfterFailure = false
    }
    
    func testInit() {
        
    }
}
