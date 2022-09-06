//
//  FavoritesView.swift
//  RandomWiki
//
//  Created by Sean Erickson on 9/3/22.
//

import SwiftUI

struct FavoritesView: View {
    // MARK: - State
    @State var itemSelected: Article?
    @State var isShowing: Bool = false
    
    // MARK: - Properties
    var favorites: [Article]
    
    // MARK: - Actions
    var onTap: ArticleClosure = {_ in}
    
    // MARK: - Body
    var body: some View {
        Text("favorites.title".localized)
            .scaledFont(name: "Montserrat-Bold", size: 36)
            .blur(radius: isShowing ? 5 : 0)
            .onTapGesture { isShowing = false }
        ScrollView {
            Divider()
            ForEach(favorites) { article in
                VStack {
                    HStack {
                        Text(article.clippedTitle)
                            .padding()
                            .scaledFont(name: "Montserrat-Medium", size: 15)
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if isShowing { isShowing = false }
                        else { onTap(article) }
                    }
                    .onLongPressGesture {
                        itemSelected = article
                        isShowing = true
                    }
                    if let description = article.description {
                        if itemSelected == article && isShowing {
                            CustomContextMenu<Text>(shows: $isShowing, content: {Text(description)})
                        }
                    }
                    Divider()
                }
                .animation(.spring(), value: isShowing)
                .blur(radius: (itemSelected != article && isShowing) ? 7.5 : 0)
            }
        }
    }
}

//struct FavoritesView_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoritesView(favorites: $[])
//    }
//}
