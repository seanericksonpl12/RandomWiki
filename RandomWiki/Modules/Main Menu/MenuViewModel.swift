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
        @Published var menuSelected: Bool = false
        @Published var settingsSelected: Bool = false
        // MARK: - Dropdown Menu
        // TODO: - Add menu contents into separate file
       
    }
}
