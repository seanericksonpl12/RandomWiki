//
//  FavoritesView.swift
//  RandomWiki
//
//  Created by Sean Erickson on 9/3/22.
//

import SwiftUI

struct FavoritesView: View {
    
    var favorites: [Article]
    
    var body: some View {
        ForEach(favorites) { article in
            Text(article.title)
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView(favorites: [])
    }
}
