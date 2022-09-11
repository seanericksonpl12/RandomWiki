//
//  ContentViewModel.swift
//  RandomWiki
//
//  Created by Sean Erickson on 8/27/22.
//

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
        @Published var loading: Bool = true
        
        // MARK: - Stored Properties
        var loadedAction: DetailsClosure = {_ in}
        var favoriteAction: ArticleClosure = {_ in}
        
        // MARK: - Init
        init() {
            self.currentArticle =  Article(id: UUID(), url: URL(string: "https://en.wikipedia.org/wiki/Special:Random"), category: "", title: "")
            self.loadedAction = { [weak self] details in
                guard let self = self else { return }
                self.currentArticle.title = details.title
                self.currentArticle.url = details.url
                self.currentArticle.description = details.description
                self.loading = false
            }
            self.favoriteAction = { [weak self] article in
                guard let self = self else { return }
                self.currentArticle = article
                self.currentArticle.saved = true
                self.loading = false
                self.menuOpen = false
            }
        }
        
        // MARK: - Public Functions
        func getArticle() {
            guard let url = URL(string: "https://en.wikipedia.org/wiki/Special:Random") else { return }
            self.loading = true
            currentArticle = Article(id: UUID(), url: url, saved: false, category: "", title: "")
        }
        
        func save() {
            currentArticle.saved.toggle()
        }
        
        func clearData() {
            self.currentArticle.saved = false
        }
    }
}
