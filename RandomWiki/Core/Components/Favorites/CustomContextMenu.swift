//
//  CustomContextMenu.swift
//  RandomWiki
//
//  Created by Sean Erickson on 9/5/22.
//

import Foundation
import SwiftUI
import UIKit

struct CustomContextMenu<Content: View>: View {
    @Binding var shows: Bool
    @ViewBuilder let content: Content

    var body: some View {
        ZStack {
            Color.black.opacity(0.05)
                .onTapGesture {
                    shows = false
                }

            VStack(alignment: .trailing) {
                Spacer()
                VStack(alignment: .trailing) {
                    content
                        .padding()
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

private struct ClearFullScreenCoverWithBlur: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}
