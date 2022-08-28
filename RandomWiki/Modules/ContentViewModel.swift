//
//  ContentViewModel.swift
//  RandomWiki
//
//  Created by Sean Erickson on 8/27/22.
//

import Foundation
import SwiftUI
import WebKit

extension ContentView {
    @MainActor class ContentViewModel: ObservableObject {
        // MARK: - Published Properties
        @Published var savedArticles: [URL] = []
        @Published var currentArticle: URL? = URL(string: "https://en.wikipedia.org/wiki/Special:Random")
        @Published var menuOpen: Bool = false
        @Published var settingsOpen: Bool = false
        
        // MARK: - Static Properties
        var menuAction: SimpleClosure = { print("menu") }
        var settingsAction: SimpleClosure = { print("settings") }
        
        func getArticle() -> URL? {
            guard let url = URL(string: "https://en.wikipedia.org/wiki/Special:Random") else { return nil }
            let webView = WKWebView()
            webView.load(URLRequest(url: url))
            
          
            return url
        }
    }
}
