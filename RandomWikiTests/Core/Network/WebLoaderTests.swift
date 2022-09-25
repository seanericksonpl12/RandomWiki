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
    override var request: URLRequest { if validURL { return URLRequest(url: URL(string:"https://en.wikipedia.org")!)} else { return URLRequest(url: URL(string: "https://www.google.com")!)}}
    var validURL: Bool = true
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
        navigation.validURL = false
        var check = 0
        await loader.webView(loader, decidePolicyFor: navigation, decisionHandler: {decision in if decision == .cancel { check+=1}})
        XCTAssertEqual(check, 1)
        check = 0
        navigation.validURL = true
        await loader.webView(loader, decidePolicyFor: navigation, decisionHandler: {decision in if decision == .allow { check+=1}})
        XCTAssertEqual(check, 1)
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
