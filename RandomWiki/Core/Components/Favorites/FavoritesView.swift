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
            ScrollViewReader { value in
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
                            if isShowing {
                                isShowing = false
                                withAnimation {
                                    value.scrollTo(article.id, anchor: .top)
                                }
                            }
                            else { onTap(article) }
                        }
                        .onLongPressGesture {
                            itemSelected = article
                            isShowing = true
                            withAnimation {
                                value.scrollTo(article.id, anchor: .top)
                            }
                        }
                        if let description = article.description {
                            if itemSelected == article && isShowing {
                                CustomContextMenu<Text>(shows: $isShowing, content: {Text(description)})
                                    .animation(.easeIn, value: isShowing)
                            }
                        }
                        if !isShowing { Divider() }
                    }
                    .animation(.spring(), value: isShowing)
                    .blur(radius: (itemSelected != article && isShowing) ? 7.5 : 0)
                }
            }
        }
        .onTapGesture { isShowing = false }
    }
}

//struct FavoritesView_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoritesView(favorites: $[])
//    }
//}
