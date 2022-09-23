//
//  WebView.swift
//  RandomWiki
//
//  Created by Sean Erickson on 8/28/22.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    var url: URL?
    var loader: WebKitLoader
    
    func makeUIView(context: Context) -> WKWebView {
        let webKit = loader
        webKit.navigationDelegate = webKit
        return webKit
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        guard let url = url else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
