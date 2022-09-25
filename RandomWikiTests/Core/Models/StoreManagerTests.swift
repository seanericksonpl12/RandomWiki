//
//  StoreManagerTests.swift
//  RandomWikiTests
//
//  Created by Sean Erickson on 9/25/22.
//

import XCTest
@testable import RandomWiki

class StoreManagerTests: XCTestCase {
    
    var store: StoreManager!
    
    override func setUp() {
        store = StoreManager()
        continueAfterFailure = false
    }
    
    func testGetProduct() {
        store.getProduct(productID: "42069")
        let exp = XCTNSPredicateExpectation(predicate: NSPredicate(block: { _,_  in return self.store.myProduct.productIdentifier == "42069" }), object: nil)
        wait(for: [exp], timeout: 4)
    }
}
