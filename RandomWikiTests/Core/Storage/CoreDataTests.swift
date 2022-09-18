//
//  CoreDataTests.swift
//  RandomWikiTests
//
//  Created by Sean Erickson on 9/18/22.
//

import XCTest
import CoreData
import SwiftUI
@testable import RandomWiki

final class CoreDataTests: XCTestCase {
    
    var coreDataStack: DataController!
    var view: ContentView!
    @FetchRequest(sortDescriptors: []) var empty: FetchedResults<RandomWiki.ArticleModel>

    override func setUp() {
        super.setUp()
        coreDataStack = DataController(.inMemory)
        view = ContentView()
        continueAfterFailure = false
    }
    
    func testSaveNew() throws {
        let id = UUID()
        let article = Article(id: id, title: "Test")
        view.viewModel.saveCoreData(article, context: coreDataStack.container.viewContext, list: empty)
        let result = try coreDataStack.container.viewContext.fetch(NSFetchRequest<RandomWiki.ArticleModel>(entityName: "ArticleModel"))
        XCTAssertEqual(id, result[0].id)
    }
    
    func testDelete() throws {
        var count: Int { try! coreDataStack.container.viewContext.count(for: NSFetchRequest<RandomWiki.ArticleModel>(entityName: "ArticleModel")) }
        let article = Article(id: UUID(), title: "Test")
        view.viewModel.saveCoreData(article, context: coreDataStack.container.viewContext, list: empty)
        let fetched = try coreDataStack.container.viewContext.fetch(NSFetchRequest<RandomWiki.ArticleModel>(entityName: "ArticleModel"))
        XCTAssertEqual(count, 1)
        coreDataStack.container.viewContext.delete(fetched[0])
        XCTAssertEqual(0, count)
    }

}
