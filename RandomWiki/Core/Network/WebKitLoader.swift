//
//  WebKitLoader.swift
//  RandomWiki
//
//  Created by Sean Erickson on 9/3/22.
//
import UIKit
import WebKit
import SwiftSoup

class WebKitLoader: WKWebView, WKNavigationDelegate {
    
    // MARK: - Actions
    var loadedAction: ArticleClosure = {_ in}
    
    // MARK: - Delegate Functions
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let favorites = UserDefaults.standard.loadArticles()
        
        webView.evaluateJavaScript("document.documentElement.outerHTML") { [weak self] html, error in
            guard let self = self else { return }
            let saved = favorites?.contains(where: {article in article.url == webView.url}) ?? false
            let tup = self.soupify(html: html)
            let article = Article(id: UUID(), url: webView.url, saved: saved, category: "", title: tup.0, description: tup.1)
            self.loadedAction(article)
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
