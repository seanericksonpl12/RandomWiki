//
//  CustomContextMenu.swift
//  RandomWiki
//
//  Created by Sean Erickson on 9/5/22.
//

import SwiftUI

struct CustomContextMenu<Content: View>: View {
    @Binding var shows: Bool
    @ViewBuilder let content: Content

    var body: some View {
        ZStack {
            Color.black.opacity(0.05)
                .onTapGesture { shows = false }
            VStack(alignment: .trailing) {
                Spacer()
                VStack(alignment: .trailing) {
                    content
                        .padding()
                        .onTapGesture { shows = false }
                        .lineLimit(10)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .cornerRadius(10)
        .padding()
        .ignoresSafeArea()
        .transition(AnyTransition.opacity.animation(.easeInOut))
    }
}
