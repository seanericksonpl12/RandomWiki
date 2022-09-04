//
//  WebKitLoader.swift
//  RandomWiki
//
//  Created by Sean Erickson on 9/3/22.
//
import UIKit
import WebKit

class WebKitLoader: WKWebView, WKNavigationDelegate {
    
    var loadedAction: URLClosure = {_ in}

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadedAction(webView.url)
        webView.evaluateJavaScript("document.title") { html, error in
            // TODO: - send title to ContentViewModel on load
           // print(html)
        }
    }
}
