//
//  ContentView.swift
//  RandomWiki
//
//  Created by Sean Erickson on 8/26/22.
//

import SwiftUI
import UserNotifications
import WebKit
import AVFoundation

struct ContentView: View {
    
    // MARK: - Dependencies
    @StateObject var viewModel: ContentViewModel = ContentViewModel()
    
    // MARK: - Core Data
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: []) var favorites: FetchedResults<ArticleModel>
    
    // MARK: - In-App Purchase Manager
    @ObservedObject var store: StoreManager
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack {
                        HStack {
                            Text(UserDefaults.standard.getNotificationOptions() == .daily ? "menu.title".localized : "menu.title.weekly".localized)
                                .scaledFont(name: "Montserrat-Bold", size: UserDefaults.standard.getNotificationOptions() == .daily ? 36 : 34)
                        }
                        .padding(.leading, 10)
                        Spacer()
                        // MARK: - Icon Bar
                        HStack(spacing: 20) {
                            Image(systemName: favorites.contains {$0.id == viewModel.currentArticle.id} ? "star.fill" : "star" )
                                .foregroundColor(.yellow)
                                .onTapGesture {
                                    viewModel.saveCoreData(viewModel.currentArticle, context: managedObjectContext, list: favorites)
                                }
                            Image(systemName: viewModel.isPlaying ? "pause.fill" : "play.fill")
                                .foregroundColor(.gray)
                                .onTapGesture {
                                    viewModel.readArticle()
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
                        WebView(url: viewModel.curURL,
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
                MenuView(store: store, width: 300, isOpen: viewModel.menuOpen, menuClose: self.openMenu, favoritesAction: viewModel.favoriteAction)
                    .animation(.easeInOut, value: viewModel.menuOpen)
            }
            .navigationBarHidden(true)
        }
        .onReceive(NotificationCenter.default.publisher(for: .updateWebView)) { _ in
            viewModel.getArticle()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.significantTimeChangeNotification)) { _ in
            viewModel.getArticle()
        }
        .onReceive(NotificationCenter.default.publisher(for: .readText)) { _ in
            viewModel.readArticle(inBackground: true)
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
        ContentView(viewModel: ContentView.ContentViewModel(), store: StoreManager())
            .previewInterfaceOrientation(.portrait)
    }
}
