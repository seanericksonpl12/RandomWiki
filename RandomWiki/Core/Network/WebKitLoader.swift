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
    // MARK: - Stored Properties
    var cssFile: String? = Bundle.main.path(forResource: "styleSheet", ofType: "css")
    var frameInfo: WKFrameInfo = WKFrameInfo()
    var canGoBackWithRefresh: Bool = false
    
    // MARK: - Overrides
    override var canGoBack: Bool { return canGoBackWithRefresh }
    
    // MARK: - Calculated Properties
    var jscriptFontSize: String {
        if UserDefaults.standard.scaledFontEnabled() {
            return (UIFontMetrics.default.scaledValue(for: 16)).formatted() + "px"
        } else { return "\(UserDefaults.standard.fontSize())px" }
    }
    
    // MARK: - Actions
    var loadedAction: DetailsClosure = {_ in}
}

// MARK: - Delegate Functions
extension WebKitLoader {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.navigationType == .linkActivated { self.canGoBackWithRefresh = true }
        if !(navigationAction.request.url?.absoluteString.contains("wikipedia.org") ?? false) { decisionHandler(.cancel) }
        else { decisionHandler(.allow) }
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        runJavascript(on: webView)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        webView.evaluateJavaScript("document.documentElement.outerHTML") { [weak self] html, error in
            guard let self = self else { return }
            let tup = self.soupify(html: html)
            let details = ArticleDetails(url: webView.url, title: tup.0, description: tup.1)
            self.loadedAction(details)
        }
        webView.allowsBackForwardNavigationGestures = self.canGoBack
    }
}

// MARK: - HTML Parsing Functions
extension WebKitLoader {
    
    func soupify(html: Any?) -> (String, String) {
        guard let html = html as? String else { return ("", "") }
        var title = ""
        var description = "favorites.noDescription".localized
        var doc: Document
        do { doc = try SwiftSoup.parse(html) } catch { return("", "") }
        do { title = try doc.title() } catch { print(error) }
        do {
            let imgs = try doc.select("img").array()
            let img = try imgs.first(where: { try $0.attr("src").hasPrefix("//upload")})
            if let imgString = try img?.attr("src") {
                if let ud = UserDefaults(suiteName: "group.com.RandomWikiWidget") {
                    let fullUrl = "https:" + imgString
                    ud.set(fullUrl, forKey: "storedImage")
                    print(fullUrl)
                }
            }
        } catch {print("images not found")}
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
        do {
            let css = try "\"" + String(contentsOfFile: cssFile!).trimmingCharacters(in: CharacterSet.newlines) + "main {font-size: \(jscriptFontSize)}\""
            let jsString = "var style=document.createElement('style');style.innerHTML=\(css);document.head.appendChild(style);"
            webView.callAsyncJavaScript(jsString, in: self.frameInfo, in: WKContentWorld.page)
        } catch { print(error) }
    }
}

extension WebKitLoader {
    
    func getPageImage(url: URL, completionHandler: (URL) -> Void) {
        
    }
}
