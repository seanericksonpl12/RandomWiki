//
//  DropDownView.swift
//  RandomWiki
//
//  Created by Sean Erickson on 8/30/22.
//
import SwiftUI

struct MenuContentsView: View {
    // MARK: - Properties
    var selected: Bool
    var favorites: [Article]
    
    // MARK: - Actions
    var favoriteAction: ArticleClosure
    
    // MARK: - Body
    var body: some View {
        HStack {
            content
            Spacer()
        }
    }
    
    // MARK: - Main Content
    var content: some View {
        VStack {
            HStack {
                Text("Menu")
                    .foregroundColor(.black)
                    .scaledFont(name: "montserrat", size: 16.0)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 4, trailing: 20))
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                    .rotationEffect(.degrees(selected ? 90 : 0))
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 4, trailing: 20))
            }
            if selected {
                MenuItem<FavoritesView>(iconName: "star.fill",
                                        iconColor: .yellow,
                                        title: "favorites.title".localized) {
                    FavoritesView(favorites: favorites, onTap: favoriteAction)
                }
            }
            Divider()
        }
    }
}


//struct DropDownView_Previews: PreviewProvider {
//    static var previews: some View {
//        DropDownView(selected: false)
//    }
//}
