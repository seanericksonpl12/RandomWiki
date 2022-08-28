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
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    viewModel.getArticle()
                } label: {
                    Text("Saved")
                        .foregroundColor(.gray)
                    
                }
                .padding(EdgeInsets(top: 15, leading: 0, bottom: 0, trailing: 20))
            }
            
            HStack {
                Text("Daily Article")
                    .scaledFont(name: "Montserrat", size: 32)
                    .padding()
                Spacer()
            }
            .padding(EdgeInsets(top: -40, leading: 0, bottom: 0, trailing: 0))
            Divider()
            WebView(url: viewModel.currentArticle!)
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
