//
//  TestFavoritesView.swift
//  RandomWikiTests
//
//  Created by Sean Erickson on 9/19/22.
//

import XCTest
import ViewInspector
import CoreData
@testable import RandomWiki
import SwiftUI

extension FavoritesView: Inspectable {}
extension Inspection: InspectionEmissary {}

final class TestFavoritesView: XCTestCase {
    
    var view: FavoritesView!
    var context: DataController!
    var content: ContentView!
    @FetchRequest(sortDescriptors: []) var empty: FetchedResults<RandomWiki.ArticleModel>
    
    override func setUp() {
        super.setUp()
        context = DataController(.inMemory)
        content = ContentView()
        view = FavoritesView()
        // Cannot start with empty data stack or VI throws error
        let id = UUID()
        let article = Article(id: id, title: "Test")
        content.viewModel.saveCoreData(article, context: context.container.viewContext, list: empty)
    }
    
    
    func testIsShowing() throws {
        let exp = view.inspection.inspect { view in
            try view.actualView().isShowing = true
            try view.find(text: "favorites.title".localized).callOnTapGesture()
            XCTAssertFalse(try view.actualView().isShowing)
        }
        ViewHosting.host(view: view.environment(\.managedObjectContext, self.context.container.viewContext))
        wait(for: [exp], timeout: 5)
    }
    
    func testLongPress() throws {
        let exp = view.inspection.inspect { view in
            let arr = view.findAll(ViewType.ForEach.self)
            try arr[0].vStack(0).hStack(0).callOnLongPressGesture()
            let article = try view.actualView().itemSelected
            XCTAssertEqual(article?.title, "Test")
        }
        ViewHosting.host(view: view.environment(\.managedObjectContext, self.context.container.viewContext))
        wait(for: [exp], timeout: 5)
    }
    
    func testTap() throws {
        var receivedArticle: Article = Article(id: UUID(), title: "fail")
        view = FavoritesView(onTap: { article in receivedArticle = article })
        let exp = view.inspection.inspect { view in
            let arr = view.findAll(ViewType.ForEach.self)
            try arr[0].vStack(0).hStack(0).callOnTapGesture()
            XCTAssertEqual(receivedArticle.title, "Test")
        }
        ViewHosting.host(view: view.environment(\.managedObjectContext, self.context.container.viewContext))
        wait(for: [exp], timeout: 5)
    }
}
