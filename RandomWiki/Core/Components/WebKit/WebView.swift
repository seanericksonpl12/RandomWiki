//
//  WebView.swift
//  RandomWiki
//
//  Created by Sean Erickson on 8/28/22.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    var url: URL
    var loadedAction: ArticleClosure = {_ in}
    
    func makeUIView(context: Context) -> WKWebView {
        let webKit = WebKitLoader()
        webKit.loadedAction = self.loadedAction
        webKit.navigationDelegate = webKit
        return webKit
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

