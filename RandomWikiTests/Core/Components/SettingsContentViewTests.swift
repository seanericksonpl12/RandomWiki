//
//  SettingsContentViewTests.swift
//  RandomWikiTests
//
//  Created by Sean Erickson on 9/20/22.
//

import XCTest
import ViewInspector
import SwiftUI
@testable import RandomWiki

extension SettingsContentView: Inspectable {}

class SettingsContentViewTests: XCTestCase {
    
    var view: SettingsContentView!
    var context: DataController!
    var content: ContentView!
    var selected: Bool!
    @FetchRequest(sortDescriptors: []) var empty: FetchedResults<RandomWiki.ArticleModel>
    
    override func setUp() {
        super.setUp()
        self.selected = true
        context = DataController(.inMemory)
        content = ContentView(store: StoreManager())
        view = SettingsContentView(store: self.content.store, selected: self.selected)
        // Cannot start with empty data stack or VI throws error
        let id = UUID()
        let article = Article(id: id, title: "Test")
        content.viewModel.saveCoreData(article, context: context.container.viewContext, list: empty)
    }
    
    
    func testClearData() throws {
        let exp = view.inspection.inspect { view in
            XCTAssertEqual(try view.actualView().favorites.count, 1)
            try view.actualView().clearData()
            XCTAssertEqual(try view.actualView().favorites.count, 0)
        }
        ViewHosting.host(view: view.environment(\.managedObjectContext, self.context.container.viewContext))
        wait(for: [exp], timeout: 5)
    }
    
    func testSelected() throws {
        view.selected = false
        XCTAssertEqual(try view.inspect().findAll(ViewType.VStack.self).count, 1)
        view.selected = true
        XCTAssertEqual(try view.inspect().findAll(ViewType.VStack.self).count, 2)
    }
    
    func testHeader() throws {
        let _ = try view.inspect().find(text: "settings.title".localized)
    }
}
