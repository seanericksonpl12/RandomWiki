//
//  MenuViewModel.swift
//  RandomWiki
//
//  Created by Sean Erickson on 8/30/22.
//

import SwiftUI
import WebKit

extension MenuView {
    @MainActor class MenuViewModel: ObservableObject {
        @Published var filtersSelected: Bool = false
        @Published var backgroundSelected: Bool = true
        // MARK: - Dropdown Menu
        // TODO: - Add menu contents into separate file
        var dropDownContent: [DropDown] = [DropDown(id: 0, label: "Settings",
                                                    children: []),
                                           DropDown(id: 1, label: "Menu",
                                                    children: [DropDown(id: 2, label: "item one", children: [])]),
                                            DropDown(id: 3, label: "Third",
                                                     children: [])]
        @Published var itemsSelected: Set<DropDown> = []
        
        func select(_ item: DropDown) {
            if itemsSelected.contains(item) {
                itemsSelected.remove(item)
            } else { itemsSelected.insert(item) }
        }
        
    }
}
