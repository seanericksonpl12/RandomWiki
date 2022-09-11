//
//  ContentView.swift
//  RandomWiki
//
//  Created by Sean Erickson on 8/26/22.
//

import SwiftUI
import UserNotifications
import WebKit

struct ContentView: View {
    
    // MARK: - Dependencies
    @StateObject var viewModel: ContentViewModel = ContentViewModel()
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: []) var favorites: FetchedResults<ArticleModel>
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack {
                        Text("menu.title".localized)
                            .scaledFont(name: "Montserrat-Bold", size: 36)
                            .padding()
                            .onTapGesture {
                                print(viewModel.currentArticle)
                            }
                        // MARK: - Icon Bar
                        HStack(spacing: 20) {
                            Image(systemName: viewModel.currentArticle.saved ? "star.fill" : "star")
                                .foregroundColor(.yellow)
                                .onTapGesture {
                                    saveCoreData(viewModel.currentArticle)
                                }
                            Image(systemName: "arrow.clockwise")
                                .foregroundColor(.gray)
                                .onTapGesture {
                                    viewModel.getArticle()
                                }
                            Image(systemName: "slider.horizontal.3")
                                .foregroundColor(.gray)
                                .onTapGesture {
                                    openMenu()
                                }
                        }
                    }
                    Divider()
                    // MARK: - Web Content
                    ZStack {
                        WebView(url: viewModel.currentArticle.url!,
                                loadedAction: viewModel.loadedAction)
                            .ignoresSafeArea()
                        if viewModel.loading {
                            LoadingView()
                                .ignoresSafeArea()
                        }
                    }
                }
                
                // MARK: - Menu Side Panel
                MenuView(width: 300, isOpen: viewModel.menuOpen, menuClose: self.openMenu, favoritesAction: viewModel.favoriteAction, clearData: {viewModel.clearData()})
                    .animation(.easeInOut, value: viewModel.menuOpen)
            }
            .navigationBarHidden(true)
        }
    }
    
    // MARK: - Menu Functions
    func openMenu() {
        viewModel.menuOpen.toggle()
    }
    func openSettings() {
        viewModel.settingsOpen.toggle()
    }
    func reload() {
        viewModel.reload.toggle()
    }
    
    // MARK: - Core Data Functions
    func delete() {
        
    }
    func saveCoreData(_ save: Article) {
        do {
            // Check if item is already in favorites list
            if save.saved {
                if let item = favorites.first(where: {item in item.id == save.id}) {
                    managedObjectContext.delete(item)
                } else { print("Error: Duplicate item not found")}
            }
            else {
                let article = ArticleModel(context: managedObjectContext)
                article.descrptn = save.description ?? ""
                article.title = save.title
                article.saved = save.saved
                article.id = save.id
                article.url = save.url
                article.expanded = save.expanded
            }
            try managedObjectContext.save()
            viewModel.save()
        } catch { print(error.localizedDescription) }
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
