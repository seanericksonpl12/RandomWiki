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
    @State var offset: CGSize = .zero
    @State var isSwiped: Bool = false
    @State var currentIndex: Int = 0
    //@State var offsets: [(CGSize, Bool)]
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
                    
                        ForEach(Array(favoritesList.enumerated()), id: \.offset) { index, article in
                            VStack {
                                
                                HStack {
                                    
                                    Text(String(article.title?.dropLast(12) ?? ""))
                                        .padding()
                                        .scaledFont(name: "Montserrat-Medium", size: 15)
                                    Spacer()
                                    Button {
                                        print("deleted.")
                                        context.delete(article)
                                        do {
                                            try context.save()
                                        } catch {print(error)}
                                        NotificationCenter.default.post(.checkCurrentArticle)
                                        self.offset = .zero
                                        
                                    } label: {
                                        Image(systemName: "xmark")
                                            .frame(maxWidth: 100, maxHeight: 50)
                                    }
                                    
                                    .background(Color.red)
                                    .foregroundColor(Color.white)
                                    .padding(.trailing, -200)
                                    .offset(self.currentIndex == index ? self.offset : .zero)
                                    
                                }
                                .background(Color("Background"))
                                .contentShape(Rectangle())
                                .gesture(DragGesture()
                                    .onChanged { gesture in
                                        currentIndex = index
                                        if (gesture.startLocation.x - gesture.location.x) > 20 || (gesture.startLocation.x - gesture.location.x) < -20 {
                                            if !isSwiped {
                                                self.offset.width = -1*(gesture.startLocation.x - gesture.location.x)
                                            } else {
                                                self.offset.width = -1*(gesture.startLocation.x - gesture.location.x) - 100
                                            }
                                        }
                                    }
                                    .onEnded { _ in
                                        if self.offset.width < -90 {
                                            self.offset.width = -100
                                            self.isSwiped = true
                                        }
                                        else {
                                            self.offset = .zero
                                            self.isSwiped = false
                                        }
                                    }
                                )
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
