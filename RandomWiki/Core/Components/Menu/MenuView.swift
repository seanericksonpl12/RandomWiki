//
//  MenuView.swift
//  RandomWiki
//
//  Created by Sean Erickson on 8/28/22.
//

import SwiftUI

struct MenuView: View {
    @StateObject private var viewModel = MenuViewModel()
    // MARK: - Properties
    let width: CGFloat
    let isOpen: Bool
    let menuClose: SimpleClosure
    let menuItems: [DropDown]
    
    
    var body: some View {
        ZStack {
            GeometryReader { _ in
                EmptyView()
            }
            .background(Color.gray.opacity(0.3))
            .opacity(self.isOpen ? 1.0 : 0.0)
            .onTapGesture {
                self.menuClose()
            }
            HStack {
                // MARK: - Menu Content
                NavigationView {
                    ScrollView {
                        Divider()
                        ForEach(viewModel.dropDownContent) { row in
                            DropDownView(selected: viewModel.itemsSelected.contains(row), dropDown: row)
                                .onTapGesture {
                                    viewModel.select(row)
                                }
                                .animation(.interactiveSpring(), value: viewModel.itemsSelected.contains(row))
                        }
                    }
                    .navigationBarHidden(true)
                }
                .frame(width: self.width)
                .background(Color.white)
            .offset(x: self.isOpen ? 0 : -self.width)
                Spacer()
            }
        }
    }
}

// MARK: - Preview
//struct MenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        MenuView(width: 250, isOpen: true, menuClose: {})
//    }
//}
