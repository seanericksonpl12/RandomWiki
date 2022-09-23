//
//  WebViewTests.swift
//  RandomWikiTests
//
//  Created by Sean Erickson on 9/16/22.
//

import XCTest
import ViewInspector
@testable import RandomWiki
import WebKit

final class MockNavAction: WKNavigationAction {
    override var navigationType: WKNavigationType { WKNavigationType.linkActivated }
}

class WebLoaderTests: XCTestCase {
    var webView: WebView!
    var loader: WebKitLoader!
    let navigation = WKNavigation()
    let mockView = WKWebView()
    
    override func setUp() {
        super.setUp()
        loader = WebKitLoader()
        webView = WebView(loader: loader)
        continueAfterFailure = false
    }
    
    func testLoadedAction() {
        var count = 0
        loader.loadedAction = {_ in count+=1 }
        webView.loader.loadedAction(RandomWiki.ArticleDetails(title: "Test"))
        XCTAssertEqual(count, 1)
    }
    
    func testCSSFile() {
        XCTAssertNotNil(loader.cssFile)
    }
    
    func testJavascript() {
        let expectation = XCTestExpectation()
        loader.evaluateJavaScript("document.documentElement.outerHTML") { html, error in
            if error != nil { XCTFail() }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
    
    func testSoupify() {
        let html = "<html><head></head><title>Test</title><body></body></html>"
        let result = loader.soupify(html: html)
        XCTAssertEqual(result.0, "Test")
    }
    
    func testNavPolicy() async {
        let navigation = MockNavAction()
        await loader.webView(loader, decidePolicyFor: navigation, decisionHandler: {_ in})
        let val = await loader.canGoBack
        XCTAssertTrue(val)
    }
    
    func testBackForwardNavigation() {
        loader.canGoBackWithRefresh = true
        loader.webView(mockView, didFinish: navigation)
        XCTAssertTrue(mockView.allowsBackForwardNavigationGestures)
        loader.canGoBackWithRefresh = false
        loader.webView(mockView, didFinish: navigation)
        XCTAssertFalse(mockView.allowsBackForwardNavigationGestures)
    }
    
    
}
