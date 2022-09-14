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
    
    var jScriptFile: String? = Bundle.main.path(forResource: "webInjection", ofType: "js")
    var frameInfo: WKFrameInfo = WKFrameInfo()
    
    // MARK: - Calculated Properties
    var darkModeEnabled: Bool { UserDefaults.standard.darkModeEnabled() }
    var jscriptFontSize: String {
        if UserDefaults.standard.scaledFontEnabled() {
            return (UIFontMetrics.default.scaledValue(for: 16)).formatted() + "px"
        } else { return "\(UserDefaults.standard.fontSize())px" }
    }
    
    // MARK: - Actions
    var loadedAction: DetailsClosure = {_ in}
    
    // MARK: - Delegate Functions
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        runJavascript(on: webView)
        webView.evaluateJavaScript("document.documentElement.outerHTML") { [weak self] html, error in
            guard let self = self else { return }
            let tup = self.soupify(html: html)
            let details = ArticleDetails(url: webView.url, title: tup.0, description: tup.1)
            self.loadedAction(details)
        }
    }
    
    // MARK: - HTML Parsing
    private func soupify(html: Any?) -> (String, String) {
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
    
    private func runJavascript(on webView: WKWebView) {
        webView.callAsyncJavaScript("document.getElementById(\"bodyContent\").style.fontSize = \"\(jscriptFontSize)\"",
                                    in: self.frameInfo,
                                    in: WKContentWorld.page)
        if darkModeEnabled {
            do {
                let javaScript = try String(contentsOfFile: jScriptFile ?? "")
                webView.callAsyncJavaScript(javaScript, in: self.frameInfo, in: WKContentWorld.page)
            } catch { print(error) }
        }
    }
}
