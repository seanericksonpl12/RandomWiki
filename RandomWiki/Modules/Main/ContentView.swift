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
    @Environment(\.dataBase.articles) var data: [Article]
    
    // MARK: - Body
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Daily Article")
                        .scaledFont(name: "Montserrat-Bold", size: 36)
                        .padding()
                        .onTapGesture {
                            print(viewModel.currentArticle)
                        }
                    
                    HStack(spacing: 20) {
                        Image(systemName: viewModel.currentArticle.saved ? "star.fill" : "star")
                            .foregroundColor(.yellow)
                            .onTapGesture {
                                viewModel.save()
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
                
                WebView(url: viewModel.currentArticle.url!, loadedAction: viewModel.loadedAction)
                    .ignoresSafeArea()
            }
            
            // MARK: - Menu Side Panel
            MenuView(width: 300, isOpen: viewModel.menuOpen, menuClose: self.openMenu, menuItems: [], favoritesAction: viewModel.favoriteAction)
                .animation(.easeIn, value: viewModel.menuOpen)
                .environment(\.dataBase.articles, viewModel.favoritesList)
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
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ContentView.ContentViewModel())
            .previewInterfaceOrientation(.portrait)
    }
}
