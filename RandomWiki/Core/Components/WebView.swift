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
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

