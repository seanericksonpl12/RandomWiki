//
//  ContentViewModel.swift
//  RandomWiki
//
//  Created by Sean Erickson on 8/27/22.
//

import SwiftUI
import UIKit
import WebKit
import CoreData

extension ContentView {
    @MainActor class ContentViewModel: ObservableObject {
        // MARK: - Published Properties
        @Published var currentArticle: Article
        @Published var menuOpen: Bool = false
        @Published var settingsOpen: Bool = false
        @Published var loading: Bool = true
        @Published var isPlaying: Bool = false
        
        @AppStorage("url") var curURL: URL = UserDefaults.standard.currentURL()
        
        // MARK: - Stored Properties
        var favoriteAction: ArticleClosure = {_ in}
        var loader: WebKitLoader = WebKitLoader()
        var speaker: SpeechHandler = SpeechHandler()
        
        // MARK: - Init
        init() {
            self.currentArticle =  Article(id: UUID(), url: URL(string: "https://en.wikipedia.org/wiki/Special:Random"), category: "", title: "")
            self.loader.loadedAction = { [weak self] details in
                guard let self = self else { return }
                self.currentArticle.title = details.title
                self.curURL = details.url ?? URL(string: "https://en.wikipedia.org/wiki/Special:Random")!
                self.currentArticle.url = details.url
                self.currentArticle.description = details.description
                self.loading = false
            }
            self.favoriteAction = { [weak self] article in
                guard let self = self else { return }
                self.currentArticle = article
                self.curURL = article.url ?? URL(string: "https://en.wikipedia.org/wiki/Special:Random")!
                self.currentArticle.saved = true
                self.loading = false
                self.menuOpen = false
            }
            self.speaker.startAction = { [weak self] in
                guard let self = self else { return }
                self.isPlaying = true
            }
            self.speaker.completionHandler = { [weak self] in
                guard let self = self else { return }
                self.isPlaying = false
            }
        }
        
        // MARK: - Public Functions
        func getArticle() {
            guard let url = URL(string: "https://en.wikipedia.org/wiki/Special:Random") else { return }
            self.loading = true
            self.loader.canGoBackWithRefresh = false
            currentArticle = Article(id: UUID(), url: url, saved: false, category: "", title: "")
            self.curURL = currentArticle.url ?? URL(string: "https://en.wikipedia.org/wiki/Special:Random")!
        }
        
        func save() {
            currentArticle.saved.toggle()
        }
        
        func clearData() {
            self.currentArticle.saved = false
        }
        
        // MARK: - Core Data
        func saveCoreData(_ save: Article, context: NSManagedObjectContext, list: FetchedResults<ArticleModel>) {
            do {
                // Check if item is already in favorites list
                if save.saved {
                    if let item = list.first(where: { $0.id == save.id}) {
                        context.delete(item)
                    } else { print("Error: Duplicate item not found") }
                }
                else {
                    let article = ArticleModel(context: context)
                    article.descrptn = save.description ?? "favorites.noDescription".localized
                    article.title = save.title
                    article.saved = save.saved
                    article.id = save.id
                    article.url = save.url
                    article.expanded = save.expanded
                }
                try context.save()
                self.save()
            } catch { print(error.localizedDescription) }
        }
        
        // MARK: - Text to Speech
        func readArticle(inBackground: Bool = false) {
            if isPlaying == true { speaker.synth.pauseSpeaking(at: .immediate) }
            else if !speaker.synth.continueSpeaking() {
                guard let description = self.currentArticle.description else { return }
                let line = self.currentArticle.title + ". " + description
                if inBackground {
                    speaker.backgroundSpeak(line: line)
                } else {
                    speaker.speak(line: line)
                }
            }
        }
    }
}
