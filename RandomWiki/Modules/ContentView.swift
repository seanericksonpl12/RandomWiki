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
                    viewModel.savedAction()
                } label: {
                    HStack {
                        Text("Saved")
                            .foregroundColor(.gray)
                        Image(systemName: "star.circle.fill")
                            .foregroundColor(.yellow)
                    }
                }
                .padding()
            }
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
