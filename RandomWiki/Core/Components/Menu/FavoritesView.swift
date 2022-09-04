//
//  FavoritesView.swift
//  RandomWiki
//
//  Created by Sean Erickson on 9/3/22.
//

import SwiftUI

struct FavoritesView: View {
    
    var favorites: [Article]
    var onTap: ArticleClosure = {_ in}
    // TODO: - Add list of favorited articles, display them on tap
    var body: some View {
        ScrollView {
            Divider()
            ForEach(favorites) { article in
                VStack {
                HStack {
                    Text(article.title)
                        .padding()
                    Spacer()
                }
                .onTapGesture {
                    print("tapped")
                }
                Divider()
                }
            }
        }
    }
}

//struct FavoritesView_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoritesView(favorites: $[])
//    }
//}
