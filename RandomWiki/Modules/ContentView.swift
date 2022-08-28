//
//  ContentView.swift
//  RandomWiki
//
//  Created by Sean Erickson on 8/26/22.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    var navigationBar: NavigationBar = NavigationBar()
    
    var body: some View {
        ZStack {
            VStack {
                NavigationBar(menuAction: self.openMenu, settingsAction: self.openSettings)
                    .padding(EdgeInsets(top: 15, leading: 0, bottom: 0, trailing: 20))
                    .ignoresSafeArea()
                    .statusBar(hidden: true)
                HStack {
                    Text("Daily Article")
                        .scaledFont(name: "Montserrat", size: 36)
                        .padding()
                    Spacer()
                }
                .padding(EdgeInsets(top: -70, leading: 0, bottom: 0, trailing: 0))
                Divider()
                WebView(url: viewModel.currentArticle!)
                    .ignoresSafeArea()
            }
            MenuView(width: 300, isOpen: viewModel.menuOpen, menuClose: self.openMenu)
                .animation(.easeIn, value: viewModel.menuOpen)
            SettingsView(width: 300, isOpen: viewModel.settingsOpen, settingClose: self.openSettings)
                .animation(.easeIn, value: viewModel.settingsOpen)
        }
    }
    
    func openMenu() {
        viewModel.menuOpen.toggle()
    }
    func openSettings() {
        viewModel.settingsOpen.toggle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
