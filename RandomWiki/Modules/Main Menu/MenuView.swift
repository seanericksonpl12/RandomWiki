//
//  MenuView.swift
//  RandomWiki
//
//  Created by Sean Erickson on 8/28/22.
//

import SwiftUI

struct MenuView: View {
    // MARK: - Dependencies
    @StateObject private var viewModel = MenuViewModel()
    
    // MARK: - Properties
    let width: CGFloat
    let isOpen: Bool
    let menuClose: SimpleClosure
    
    // MARK: - Actions
    var favoritesAction: ArticleClosure
    var clearData: SimpleClosure
    
    var body: some View {
        
        VStack {
            if isOpen {
                ZStack {
                    GeometryReader { _ in
                        EmptyView()
                    }
                    .background(Color.gray.opacity(0.3))
                    .opacity(self.isOpen ? 1.0 : 0.0)
                    .onTapGesture {
                        self.menuClose()
                    }
                    VStack{
                        HStack {
                            // MARK: - Menu Content
                            VStack {
                                Divider()
                                MenuContentsView(selected: viewModel.menuSelected, favoriteAction: favoritesAction)
                                    .modifier(MenuItemModifier(selected: $viewModel.menuSelected))
                                SettingsContentView(selected: viewModel.settingsSelected, clearData: clearData)
                                    .modifier(MenuItemModifier(selected: $viewModel.settingsSelected))
                            }
                            .frame(width: self.width)
                            .background(Color.white)
                            .cornerRadius(15)
                            Spacer()
                        }
                        .padding(.top, 20)
                        Spacer()
                    }
                }
            }
        }
    }
}

// MARK: - Preview
//struct MenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        MenuView(width: 250, isOpen: true, menuClose: {})
//    }
//}
