//
//  ContentViewModel.swift
//  RandomWiki
//
//  Created by Sean Erickson on 8/27/22.
//

import Foundation
import SwiftUI
import UIKit
import WebKit

extension ContentView {
    @MainActor class ContentViewModel: ObservableObject {
        // MARK: - Published Properties
        @Published var savedArticles: [Article] = []
        @Published var currentArticle: Article = Article(id: UUID(), url: URL(string: "https://en.wikipedia.org/wiki/Special:Random"), category: "", title: "")
        @Published var menuOpen: Bool = false
        @Published var settingsOpen: Bool = false
        @Published var reload: Bool = false
        
        // MARK: - Stored Properties
        var loadedAction: URLClosure = {_ in}
        
        // MARK: - Init
        init() {
            self.loadedAction = { [weak self] url in
                guard let self = self else { return }
                guard let url = url else { return }
                self.getArticleData(url)
            }
        }
    
        // MARK: - Public Functions
        func getArticle() {
            guard let url = URL(string: "https://en.wikipedia.org/wiki/Special:Random") else { return }
            currentArticle = Article(id: UUID(), url: url, saved: false, category: "", title: "")
        }
        
        func save() {
            currentArticle.saved.toggle()
            if currentArticle.saved { savedArticles.append(currentArticle) }
            else { savedArticles.removeAll(where: {article in
                 article.url == currentArticle.url
            })}
        }
        
        func getArticleData(_ url: URL) {
            // TODO: - Add string parsing for grabbing title
            self.currentArticle = Article(id: UUID(), url: url, saved: false, category: "", title: "")
        }
    }
}
