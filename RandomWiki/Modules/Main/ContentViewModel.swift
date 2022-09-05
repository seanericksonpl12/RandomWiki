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
        @Published var currentArticle: Article
        @Published var menuOpen: Bool = false
        @Published var settingsOpen: Bool = false
        @Published var reload: Bool = false
        @Published var favoritesList: [Article]
        
        // MARK: - Stored Properties
        var loadedAction: ArticleClosure = {_ in}
        var favoriteAction: ArticleClosure = {_ in}
        
        // MARK: - Init
        init() {
            self.currentArticle =  Article(id: UUID(), url: URL(string: "https://en.wikipedia.org/wiki/Special:Random"), category: "", title: "")
            self.favoritesList = UserDefaults.standard.loadArticles() ?? []
            self.loadedAction = { [weak self] article in
                guard let self = self else { return }
                self.currentArticle = article
            }
            self.favoriteAction = { [weak self] article in
                guard let self = self else { return }
                self.currentArticle = article
                self.menuOpen = false
            }
        }
    
        // MARK: - Public Functions
        func getArticle() {
            guard let url = URL(string: "https://en.wikipedia.org/wiki/Special:Random") else { return }
            currentArticle = Article(id: UUID(), url: url, saved: false, category: "", title: "")
        }
        
        func save() {
            currentArticle.saved.toggle()
            if currentArticle.saved {
                favoritesList.append(currentArticle)
                UserDefaults.standard.saveArticles(favoritesList)
            }
            else { favoritesList.removeAll(where: { article in
                 article.url == currentArticle.url
            })
                UserDefaults.standard.saveArticles(favoritesList)
            }
        }
    }
}
