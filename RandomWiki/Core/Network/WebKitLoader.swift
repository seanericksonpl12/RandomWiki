//
//  WebKitLoader.swift
//  RandomWiki
//
//  Created by Sean Erickson on 9/3/22.
//
import UIKit
import WebKit

class WebKitLoader: WKWebView, WKNavigationDelegate {
    
    var loadedAction: ArticleClosure = {_ in}

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        webView.evaluateJavaScript("document.title") { [weak self] html, error in
            // TODO: - send title to ContentViewModel on load
            guard let self = self else { return }
            
            let article = Article(id: UUID(), url: webView.url, saved: false, category: "", title: html as? String ?? "")
            self.loadedAction(article)
        }
    }
}
