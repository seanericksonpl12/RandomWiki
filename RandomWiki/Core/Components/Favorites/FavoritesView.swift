//
//  FavoritesView.swift
//  RandomWiki
//
//  Created by Sean Erickson on 9/3/22.
//

import SwiftUI

struct FavoritesView: View {
    // MARK: - State
    @State var itemSelected: ArticleModel?
    @State var isShowing: Bool = false
    @FetchRequest(sortDescriptors: []) var favoritesList: FetchedResults<ArticleModel>
    @Environment(\.managedObjectContext) var context
    
    // MARK: - Actions
    var onTap: ArticleClosure = {_ in}
    
    // MARK: - View Inspector
    internal let inspection = Inspection<Self>()
    
    // MARK: - Body
    var body: some View {
        VStack {
            Text("favorites.title".localized)
                .scaledFont(name: "Montserrat-Bold", size: 36)
                .blur(radius: isShowing ? 5 : 0)
                .onTapGesture { isShowing = false }
            ScrollView {
                ScrollViewReader { value in
                    Divider()
                    ForEach(favoritesList) { article in
                        VStack {
                            HStack {
                                Text(String(article.title?.dropLast(12) ?? ""))
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
                                else {
                                    let generatedArticle = Article(id: article.id ?? UUID(),
                                                                   url: article.url,
                                                                   saved: article.saved,
                                                                   category: "",
                                                                   title: article.title ?? "",
                                                                   description: article.descrptn,
                                                                   expanded: article.expanded)
                                    onTap(generatedArticle)
                                }
                            }
                            .onLongPressGesture {
                                UISelectionFeedbackGenerator().selectionChanged()
                                itemSelected = article
                                isShowing = true
                                withAnimation {
                                    value.scrollTo(article.id, anchor: .bottom)
                                }
                            }
                            if let description = article.descrptn {
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
                    if favoritesList.isEmpty {
                        Text("favorites.empty".localized)
                            .scaledFont(name: "Montserrat-Medium", size: 16)
                            .padding()
                    }
                }
            }
            .onTapGesture { isShowing = false }
            .background(Color("Background"))
        }
        .background(Color("Background-Light"))
        .onReceive(inspection.notice) { self.inspection.visit(self, $0) }
    }
}
