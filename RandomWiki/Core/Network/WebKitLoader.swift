//
//  WebKitLoader.swift
//  RandomWiki
//
//  Created by Sean Erickson on 9/3/22.
//
import UIKit
import SwiftUI
import WebKit
import SwiftSoup

class WebKitLoader: WKWebView, WKNavigationDelegate {
    var frameInfo: WKFrameInfo = WKFrameInfo()
    
    var jscriptFontSize: String {
        if UserDefaults.standard.scaledFontEnabled() {
            return (UIFontMetrics.default.scaledValue(for: 16)).formatted() + "px"
        } else { return "16px" }
    }
    
    // MARK: - Actions
    var loadedAction: DetailsClosure = {_ in}
    
    // MARK: - Delegate Functions
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {

            webView.callAsyncJavaScript("document.getElementById(\"bodyContent\").style.fontSize = \"\(jscriptFontSize)\"",
                                        in: self.frameInfo,
                                        in: WKContentWorld.page)
        webView.evaluateJavaScript("document.documentElement.outerHTML") { [weak self] html, error in
            guard let self = self else { return }
            
            // TODO: - Fix article creation
            let tup = self.soupify(html: html)
//            var id = UUID()
//            var saved = false
////            if let newId = self.checkIDAction(webView.url) {
////                id = newId
////                saved = true
////            } else { id = UUID() }
//            let article = Article(id: id, url: webView.url, saved: saved, category: "", title: tup.0, description: tup.1)
            let details = ArticleDetails(url: webView.url, title: tup.0, description: tup.1)
            self.loadedAction(details)
        }
    }
    
    // MARK: - HTML Parsing
    func soupify(html: Any?) -> (String, String) {
        guard let html = html as? String else { return ("", "") }
        var title = ""
        var description = "favorites.noDescription".localized
        var doc: Document
        do { doc = try SwiftSoup.parse(html) } catch { return("", "") }
        do { title = try doc.title() } catch { print(error) }
        do {
            let text: Elements = try doc.select("p")
            if text.count > 0 {
                if text[0].hasClass("mw-empty-elt") && text.count > 1 {
                    description = try text[1].text()
                } else { description = try text[0].text() }
            }
        } catch { print(error) }
        return (title, description)
    }
}
