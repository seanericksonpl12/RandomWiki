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
    
    // MARK: - Core Data
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: []) var favorites: FetchedResults<ArticleModel>
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack {
                        HStack {
                            Text("menu.title".localized)
                                .scaledFont(name: "Montserrat-Bold", size: 36)
                        }
                        .padding(.leading, 10)
                        Spacer()
                        // MARK: - Icon Bar
                        HStack(spacing: 20) {
                            Image(systemName: viewModel.currentArticle.saved ? "star.fill" : "star")
                                .foregroundColor(.yellow)
                                .onTapGesture {
                                    viewModel.saveCoreData(viewModel.currentArticle, context: managedObjectContext, list: favorites)
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
                        .padding(.trailing, 10)
                    }
                    // MARK: - Web Content
                    ZStack {
                        WebView(url: viewModel.currentArticle.url,
                                loader: viewModel.loader)
                        .ignoresSafeArea()
                        if viewModel.loading {
                            LoadingView()
                                .ignoresSafeArea()
                        }
                    }
                }
                .background(Color("Background-Light"))
                
                // MARK: - Menu Side Panel
                MenuView(width: 300, isOpen: viewModel.menuOpen, menuClose: self.openMenu, favoritesAction: viewModel.favoriteAction)
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
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
