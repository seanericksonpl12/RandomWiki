//
//  ViewExtensions.swift
//  RandomWiki
//
//  Created by Sean Erickson on 9/6/22.
//

import SwiftUI

struct MenuItemModifier: ViewModifier {
    @Binding var selected: Bool
    func body(content: Content) -> some View {
        content
            .contentShape(Rectangle())
            .onTapGesture {
                selected.toggle()
            }
            .animation(.spring(response: 0.25, dampingFraction: 0.5), value: selected)
    }
}
